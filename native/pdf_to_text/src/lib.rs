use poppler::Document;
use rustler::Binary;
use std::fs;

#[rustler::nif]
fn from_path(path: String) -> Result<String, String> {
    let data = fs::read(path).map_err(stringify)?;
    to_text(&data)
}

#[rustler::nif]
fn from_content(content: Binary) -> Result<String, String> {
    to_text(content.as_slice())
}

fn to_text(data: &[u8]) -> Result<String, String> {
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

fn stringify<Displayable: std::fmt::Display>(e: Displayable) -> String {
    format!("{}", e)
}

rustler::init!("Elixir.PdfToText", [
    from_path,
    from_content
]);
