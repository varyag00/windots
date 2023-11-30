@echo off

REM yasb doesn't have releases or prebuilt binaries
REM see these tickets: https://github.com/denBot/yasb/issues/87 https://github.com/denBot/yasb/pull/98

git clone https://github.com/denBot/yasb.git C:\Users\dgonz\SRC\yasb
cd C:\Users\dgonz\SRC\yasb
pip install -r requirements.txt

REM TODO: install https://github.com/and3rson/graph-bars-font/blob/master/Bars-regular.otf

REM TODO: copy or symlink config/.yasb $HOME/.yasb

REM TODO: the rest i guess. Or wait for prebuilt binaries and/or winget release
