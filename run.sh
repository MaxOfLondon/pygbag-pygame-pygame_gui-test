#! /bin/bash

# Usage:
# chmod +x ./run.sh
# source ./run.sh .venv

confirm() {
    DEFAULT="y"
    echo -e "\033[32m"
    read -e -p "$* " PROCEED
    echo -e "\033[0m\n"
    PROCEED="${PROCEED:-${DEFAULT}}"
    [[ $PROCEED = [Yy] ]]
}

in_venv=$(python3 -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")')

if [[ $in_venv ]]; then
    rm -rf $1
    deactivate
fi

python3 -m pip install --user virtualenv
virtualenv -q -p /usr/bin/python3 $1
source $1/bin/activate
pip install -r requirements.txt

confirm '[+] Run main.py without pygbag? (Y/n)' && {
    python3 main.py
}

confirm '[+] Run main.py with pygbag? (Y/n)' && {
    pwd=${PWD##*/}
    pygbag ../$pwd
}