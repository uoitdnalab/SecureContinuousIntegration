#	This program should be executed as ./ProjectTests/test-001-path_traversal.sh
#	not as ./test-001-path_traversal.sh

#Get current directory
ROOT_DIR=$(pwd)

#Configure DotDotPwn
cd ~/dotdotpwn/dotdotpwn
mkdir Reports

#Run test with DotDotPwn
echo -ne '\n' | ./dotdotpwn.pl -m http-url -u http://127.0.0.1:5000/get_file/TRAVERSAL -f /etc/passwd -k "root:" -d 6 -t 100 -s -r traversal_report.log

#Copy DotDotPwn log file to working directory
cp Reports/traversal_report.log $ROOT_DIR

#Switch back to original directory
cd $ROOT_DIR

#Parse DotDotPwn's log
python parse_dotdotpwn.py traversal_report.log ProjectGitRepo/flask_webapp.py ProjectTests/test-001-path_traversal.sh json/path_traversal.json

