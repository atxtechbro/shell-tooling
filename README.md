# Shell Tooling

Welcome to the shell-tooling repo! Here lies a collection of bash aliases and scripts that are as fun to use as their names suggest.

## What's Inside?

### `grabout` - Your Interactive Bash Command Clipboard Buddy! 🚀

Tired of manually highlighting and copying that last command you just typed?  Wish you could just *poof* 🪄 it straight to your clipboard?  Then `grabout` is your new best friend!

**What it does:**

`grabout` is a super-simple **bash alias** that snatches the **text of your last executed command** and whisks it away to your clipboard.  Think of it as your personal command-copying ninja, ready to spring into action whenever you need to re-use or tweak a command.

**Perfect for:**

*   **Re-running commands with slight edits:**  Need to change just a tiny part of that complex command you just typed? `grabout` it, paste, edit, and boom! 💥
*   **Quickly grabbing error messages:** Yes, the "error message whisperer" vibe is still strong! Copy those error messages in a flash to share with your AI overlords (or, you know, for troubleshooting 🤓).
*   **Boosting your interactive shell workflow:**  Stop wasting time with manual copying! `grabout` is all about speed and efficiency in your *interactive* bash sessions.

**How it works (the super short version):**

It's a single-line bash magic trick using the `fc -s -1` incantation to grab the last command and `xclip` to beam it to your clipboard. ✨

**Important - Interactive Bash Only! ⚠️**

Just a heads-up, `grabout` is designed to be a **purely interactive bash alias**.  Due to the mystical ways of bash history and built-in commands like `fc`, it works best (and really *only* reliably) when you use it directly in your **interactive bash terminal**.

Don't expect it to work perfectly in scripts or other non-interactive environments – it's a creature of the interactive bash realm! 🧙‍♂️

**Say farewell to manual copying in your interactive shell and hello to `grabout`!**  Clipboard-powered command ninja skills, unlocked! 🔓

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
