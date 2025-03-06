if ! dpkg -l bash-completion &> /dev/null; then
    sudo apt install -y bash-completion
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi