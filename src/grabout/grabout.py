import os
import platform
from typing import Optional, Tuple
from . import grabout_rust

def get_last_command() -> str:
    """Get the last command from shell history using native implementations."""
    if platform.system() == "Windows":
        return grabout_rust.get_last_command_windows()
    else:
        return grabout_rust.get_last_command_unix()

def run_command(cmd: str) -> Tuple[str, str, int]:
    """Run a command using the Rust backend for better performance."""
    return grabout_rust.run_command_fast(cmd)

def format_output(cmd: str, stdout: str, stderr: str) -> str:
    """Format command and its output for clipboard."""
    output = [f"Command: {cmd}"]
    
    if stdout:
        output.append("\nOutput:")
        output.append(stdout)
    
    if stderr:
        output.append("\nErrors:")
        output.append(stderr)
    
    return "\n".join(output)

def grab_output(cmd: Optional[str] = None) -> str:
    """
    Grab the output of a command and copy to clipboard.
    Uses Rust backend for performance.
    """
    if cmd is None:
        cmd = get_last_command()
    
    stdout, stderr, returncode = run_command(cmd)
    formatted = format_output(cmd, stdout, stderr)
    
    grabout_rust.set_clipboard_content(formatted)
    return formatted 