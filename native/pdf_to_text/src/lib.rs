use pdf_extract::{self, PlainTextOutput, output_doc};
use lopdf::Document;
use rustler::Binary;

#[rustler::nif]
fn from_path(path: String) -> Result<String, String> {
    pdf_extract::extract_text(path).map_err(stringify_error)
}

#[rustler::nif]
fn from_content(content: Binary) -> Result<String, String> {
    let mut s = String::new();
    {
        let mut output = PlainTextOutput::new(&mut s);
        let doc = Document::load_mem(content.as_slice()).map_err(stringify_error)?;
        output_doc(&doc, &mut output).map_err(stringify_error)?;
    }
    Ok(s)
}

fn stringify_error<Displayable: std::fmt::Display>(e: Displayable) -> String {
    format!("{}", e)
}

rustler::init!("Elixir.PdfToText", [
    from_path,
    from_content
]);
