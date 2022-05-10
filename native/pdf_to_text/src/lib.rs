use poppler::Document;
use rustler::LocalPid;
use rustler::{Atom, Binary, Encoder, Env, OwnedEnv, Term};
use std::fs;
use std::thread;

mod atoms;

#[rustler::nif]
fn from_path(pid: LocalPid, atom: Atom, from: Term, path: String) -> Atom {
    let mut thread_env = OwnedEnv::new();
    let from = thread_env.save(from);

    thread::spawn(move || {
        thread_env.send_and_clear(&pid, move |env| {
            convert_result(env, atom, from.load(env), path_to_text(path))
        });
    });
    atoms::ok()
}

#[rustler::nif]
fn from_content(pid: LocalPid, atom: Atom, from: Term, content: Binary) -> Atom {
    let content = content.to_owned().expect("failed to allocate memory");
    let mut thread_env = OwnedEnv::new();
    let from = thread_env.save(from);

    thread::spawn(move || {
        thread_env.send_and_clear(&pid, move |env| {
            convert_result(
                env,
                atom,
                from.load(env),
                content_to_text(content.as_slice()),
            )
        });
    });
    atoms::ok()
}

fn path_to_text(path: String) -> Result<String, String> {
    let data = fs::read(path).map_err(stringify)?;
    content_to_text(&data)
}

fn content_to_text(data: &[u8]) -> Result<String, String> {
    let document = Document::from_data(data, None).map_err(stringify)?;
    let mut out = String::new();
    for i in 0..document.n_pages() {
        if let Some(page) = document.page(i) {
            if let Some(text) = page.text() {
                out = out + &text + "\n\n;"
            }
        }
    }
    Ok(out)
}

fn convert_result<'a>(
    env: Env<'a>,
    atom: Atom,
    from: Term,
    result: Result<String, String>,
) -> Term<'a> {
    match result {
        Ok(text) => (atom, from, (atoms::ok(), text)).encode(env),
        Err(error) => (atom, from, (atoms::error(), error)).encode(env),
    }
}

fn stringify<Displayable: std::fmt::Display>(e: Displayable) -> String {
    format!("{}", e)
}

rustler::init!("Elixir.PdfToText.Native", [from_path, from_content]);
