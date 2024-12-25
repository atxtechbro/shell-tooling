import pytest
from grabout.grabout import format_output, run_command, grab_output
import platform
import os

def test_run_command():
    """Test running a simple command."""
    stdout, stderr, code = run_command("echo test")
    assert stdout.strip() == "test"
    assert stderr == ""
    assert code == 0

def test_run_command_with_error():
    """Test running a command that produces an error."""
    stdout, stderr, code = run_command("ls /nonexistent")
    assert stdout == ""
    assert "No such file or directory" in stderr
    assert code != 0

def test_format_output():
    """Test output formatting."""
    cmd = "echo test"
    stdout = "test\n"
    stderr = ""
    formatted = format_output(cmd, stdout, stderr)
    assert formatted.startswith("Command: echo test")
    assert "Output:" in formatted
    assert "test" in formatted

def test_grab_output():
    """Test the main grab_output function."""
    result = grab_output("echo 'Hello World'")
    assert "Command: echo 'Hello World'" in result
    assert "Hello World" in result

@pytest.mark.skipif(
    platform.system() == "Windows" or "bash" not in os.environ.get("SHELL", ""),
    reason="Last command feature not implemented on Windows or not running in bash"
)
def test_grab_output_last_command():
    """Test grabbing output of last command (Unix-like systems with bash only)."""
    # Run a command first to ensure there's history
    run_command("echo 'test history'")
    result = grab_output()
    assert "Command:" in result 