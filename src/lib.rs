use pyo3::prelude::*;
use clipboard_win::raw as clipboard;
use std::process::Command;
use std::io::Result;

#[pyfunction]
fn get_last_command_windows() -> PyResult<String> {
    let output = Command::new("powershell")
        .args(&["-Command", "(Get-History -Count 1).CommandLine"])
        .output()?;
    
    Ok(String::from_utf8_lossy(&output.stdout).trim().to_string())
}

#[pyfunction]
fn get_last_command_unix() -> PyResult<String> {
    let output = Command::new("fc")
        .args(&["-ln", "-2", "-2"])
        .output()?;
    
    Ok(String::from_utf8_lossy(&output.stdout).trim().to_string())
}

#[pyfunction]
fn set_clipboard_content(content: &str) -> PyResult<()> {
    #[cfg(target_os = "windows")]
    {
        clipboard::set_clipboard_string(&content).map_err(|e| {
            PyErr::new::<pyo3::exceptions::PyRuntimeError, _>(e.to_string())
        })?;
    }
    #[cfg(not(target_os = "windows"))]
    {
        use x11_clipboard::Clipboard;
        let clipboard = Clipboard::new().map_err(|e| {
            PyErr::new::<pyo3::exceptions::PyRuntimeError, _>(e.to_string())
        })?;
        clipboard.store(
            clipboard.getter.atoms.primary,
            clipboard.getter.atoms.string,
            content.as_bytes(),
        ).map_err(|e| {
            PyErr::new::<pyo3::exceptions::PyRuntimeError, _>(e.to_string())
        })?;
    }
    Ok(())
}

#[pyfunction]
fn run_command_fast(cmd: &str) -> PyResult<(String, String, i32)> {
    let output = if cfg!(target_os = "windows") {
        Command::new("cmd")
            .args(&["/C", cmd])
            .output()?
    } else {
        Command::new("sh")
            .args(&["-c", cmd])
            .output()?
    };

    Ok((
        String::from_utf8_lossy(&output.stdout).to_string(),
        String::from_utf8_lossy(&output.stderr).to_string(),
        output.status.code().unwrap_or(-1)
    ))
}

#[pymodule]
fn grabout_rust(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(get_last_command_windows, m)?)?;
    m.add_function(wrap_pyfunction!(get_last_command_unix, m)?)?;
    m.add_function(wrap_pyfunction!(set_clipboard_content, m)?)?;
    m.add_function(wrap_pyfunction!(run_command_fast, m)?)?;
    Ok(())
} 