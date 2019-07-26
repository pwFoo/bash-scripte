#!/bin/bash
# Use PySimpleGUI to add an GUI input box and popup to your bash script.
# To run this script you need:
#   * Python3
#   * python3-tk
#   * PySimpleGUI
#     pip install PySimpleGUI

PopUp() {
for i in "$@"; do
    case $i in
    -T=*|--Text=*)
    TEXT="${i#*=}"
    ;;
    esac
done
	
python3 - << EOF
import PySimpleGUI as sg
sg.Popup("$TEXT")
EOF
}

InputBox() { 
for i in "$@"; do
    case $i in
    -T=*|--Text=*)
    TEXT="${i#*=}"
    ;;
    -t=*|--title=*)
    TITLE="${i#*=}"
    ;;
    esac
done

python3 - << EOF
import PySimpleGUI as sg
layout = [ [sg.Text("$TEXT"), sg.InputText()], [sg.OK()] ]
window = sg.Window("$TITLE").Layout(layout)
button, text = window.Read()
print(text[0])
EOF
}

greetings=$(InputBox --Text='Say Hello:' --title='Greetings')
echo "$greetings to the Bash!"
PopUp --Text="$greetings to all the others!"
PopUp --Text="That's it. All done."
