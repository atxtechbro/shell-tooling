# bash/aliases/general.sh

# alias to grab the last command input/output and send it straight to your clipboard for faster AI-driven automation. Think of it as your error message whisperer.
alias grabout="PREV_CMD=\$(fc -ln -2 -2 | sed \"s/^ *//\"); (echo \"Command: \$PREV_CMD\" && eval \"\$PREV_CMD\" 2>&1) | xclipc"

# alias to list files tracked by git and copy their content to the clipboard. Inspired by Linus Torvalds, of course!
alias linusfiles=\"function _linusfiles() {
    echo \"Listing files tracked by git and copying contents to clipboard, approved by Linus Torvalds himself!\";
    git ls-files > /tmp/torvalds_files.txt;
    while IFS= read -r file; do
        echo \"File: \$file\" >> /tmp/torvalds_content.txt;
        cat \"\$file\" >> /tmp/torvalds_content.txt;
        echo -e \"\\n\\n\" >> /tmp/torvalds_content.txt;
    done < /tmp/torvalds_files.txt;
    xclip -sel clip < /tmp/torvalds_content.txt;
    echo \"Done! The files have been copied to your clipboard.\";
}; _linusfiles\"
