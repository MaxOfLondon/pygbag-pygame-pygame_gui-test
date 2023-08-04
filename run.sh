#! /bin/bash

# Usage:
# chmod +x ./run.sh
# source ./run.sh .venv
#

confirm() {
    echo -e "\033[32m" 
    read -rN1 -p "$* [Y/n]? "; [[ ${REPLY:0:1} = [Yy$'\n'] ]]; 
    echo -e "\033[0m"
}

in_venv=$(python3 -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")')

if [[ $in_venv ]]; then
    deactivate
fi

python3 -m pip install --user virtualenv
virtualenv -q -p /usr/bin/python3 $1
source $1/bin/activate
pip install -r requirements.txt

confirm '[+] Run main.py without pygbag? (Y/n)'
if [ -z $REPLY ]; then
    python3 main.py
fi

confirm '[+] Run main.py with pygbag? (Y/n)'
if [ -z $REPLY ]; then
    pwd=${PWD##*/}
    pygbag ../$pwd
fi