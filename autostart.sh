#!/bin/sh
### make sure this file is chmod +x 
cd /opt/opensim/bin/
rm *.log
screen -DmS money mono ./MoneyServer.exe
