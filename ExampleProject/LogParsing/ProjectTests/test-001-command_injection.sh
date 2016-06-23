#	This program should be executed as ./ProjectTests/test-001-command_injection.sh
#	not as ./test-001-command_injection.sh

#Get current directory
ROOT_DIR=$(pwd)

#Switch to commix directory
cd ~/commix/commix

#Test first parameter (username)
yes | python commix.py --url="http://127.0.0.1:5000/do_math" --data="value_x=297" --os-cmd="echo PWNED | tee /tmp/IVE-BEEN-HACKED" --os=Unix --tmp-path=/tmp --root-dir=/var/www

#Check if it is vulnerable
if [ -e /tmp/IVE-BEEN-HACKED ]
then
	#Find the attack string
	#Copy logfile to original directory
	cp .output/127.0.0.1_5000/logs.txt $ROOT_DIR/commix_log.txt
	#Switch to original directory
	cd $ROOT_DIR
	#Analyze log file for vulnerability
	python parse_commix.py commix_log.txt ProjectGitRepo/flask_webapp.py ProjectTests/test-001-command_injection.sh 'do_math?value_x' json/command_injection.json
	#Go back to commix/commix
	cd ~/commix/commix
else
	echo "(value_x) parameter appears to be safe"
fi






