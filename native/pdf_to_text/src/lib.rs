use pdf_extract::{self, PlainTextOutput, output_doc};
use lopdf::Document;
use rustler::Binary;

#[rustler::nif]
fn from_path(path: String) -> Result<String, String> {
    pdf_extract::extract_text(path).map_err(|e| format!("{}",e))
}

#[rustler::nif]
fn from_content(content: Binary) -> Result<String, String> {
    let mut s = String::new();
    {
        let mut output = PlainTextOutput::new(&mut s);
        let doc = Document::load_mem(content.as_slice()).map_err(|e| format!("{}", e))?;
        output_doc(&doc, &mut output).map_err(|e| format!("{}", e))?;
    }
    Ok(s)
}

rustler::init!("Elixir.PdfToText", [
    from_path,
    from_content
]);
