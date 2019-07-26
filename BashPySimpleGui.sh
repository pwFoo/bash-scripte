#!/bin/bash
# Use PySimpleGUI to add an GUI input box and popup to your bash script.
# To run this script you need:
#	* Python3
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
layout = [ [sg.Text("$TEXT"), sg.InputText()],      
    	   [sg.OK()] ]

window = sg.Window("$TITLE").Layout(layout)
button, text = window.Read()
f=open(".cache/$TITLE","w+")
f.write(text[0])
f.close()
EOF
}

InputBox --Text='Say Hello:' --title='Greetings'
greetings=$(< .cache/$TITLE)
echo "$greetings"
PopUp --Text="$greetings"
PopUp --Text="That's it. All done."