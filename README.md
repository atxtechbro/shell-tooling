# Shell Tooling

Welcome to the shell-tooling repo! Here lies a collection of bash aliases and scripts that are as fun to use as their names suggest.

## What's Inside?

### `grabout`
Need to grab the last command input/output and shoot it straight to your clipboard? `grabout` is your go-to. Think of it as your error message whisperer, perfect for faster AI-driven automation workflows. Say goodbye to manually copying error messages like it's the 90s.

### `linusfiles`
Ever felt like Linus Torvalds himself while working across multiple files in a git repo? Well, now you can, minus the beard. `linusfiles` lists files tracked by git and copies their content directly to your clipboard, saving you the hassle of copying and pasting into your favorite LLM. It's like having a personal assistant, only nerdier.

## How to Use

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/shell-tooling.git
   ```

## Development Setup

Want to contribute or just tinker with the code? Here's how to set up your development environment:

1. Create a virtual environment (because we're not savages who install packages globally):
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows, use `.venv\Scripts\activate`
   ```

2. Install dependencies (we've got both Python and Rust under the hood):
   ```bash
   python -m pip install --upgrade pip setuptools wheel setuptools_rust pytest
   python -m pip install -e .
   ```

3. Run tests (and watch the green checkmarks roll in):
   ```bash
   pytest tests/ -v
   ```

## Requirements

- Python 3.8 or newer (because we like our Python fresh)
- Rust (stable) - for that blazing-fast performance
- A clipboard (yes, really)
- On Linux: X11 (for clipboard magic)
- On Windows: Just Windows being Windows is enough
- A sense of humor (optional but recommended)
