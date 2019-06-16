#!/bin/bash

echo $1

C:\\Users\\jeruiz\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe --app="$1" --disable-web-security --disable-gpu --user-data-dir=~/chromeTemp
