#!/bin/bash

#	This program should be executed as ./ProjectTests/test-001-xss.sh
#	not as ./test-001-xss.sh

#Get current directory
ROOT_DIR=$(pwd)

#Hack Iceweasel to accept JS commands being served locally on TCP[9876]
~/HackIceweasel/hack_iceweasel


##Start the server feeding Iceweasel with JS commands
#~/CodeTest_Environment/LogParsing/IceweaselMod/server_script.sh &

#Switch to home directory
cd ~

#Start Xvfb (needed for Iceweasel)
Xvfb :1 &

#Wait to ensure it starts
sleep 10

#Start Iceweasel and point it to the page we wish to test
DISPLAY=:1 iceweasel http://127.0.0.1:5000 &

#Wait for a bit
sleep 20

while [ ! -f ~/final_xss_results.html ]
do
	#Start the server feeding Iceweasel with JS commands
	~/CodeTest_Environment/LogParsing/IceweaselMod/server_script.sh
	sleep 10
done

#Copy test results file back to original directory
cp ~/final_xss_results.html $ROOT_DIR

#Switch back to original directory
cd $ROOT_DIR

#Parse the logfile for vulnerabilities
python parse_xssme.py final_xss_results.html ProjectGitRepo/flask_webapp.py ProjectTests/test-001-xss.sh json/html_injection.json
