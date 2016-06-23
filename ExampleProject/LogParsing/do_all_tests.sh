ROOT_DIR=$(pwd)

#First compile the needed C program...
cd ProjectGitRepo
gcc -o lowlevel_service lowlevel_service.c


#... then start the Flask webapp server
python flask_webapp.py &

sleep 10

#Switch back to original directory
cd $ROOT_DIR

#Run the test cases for use-after-free
./ProjectTests/test-001-use_after_free.sh
./ProjectTests/test-002-use_after_free.sh
./ProjectTests/test-003-use_after_free.sh


#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/use_after_free.json > /dev/null

#Run the test cases for SQL injection
./ProjectTests/test-001-sql_injection.sh

#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/sql_injection.json > /dev/null

#Run the test cases for command injection
./ProjectTests/test-001-command_injection.sh

#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/command_injection.json > /dev/null

#Run the test cases for path traversal
./ProjectTests/test-001-path_traversal.sh

#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/path_traversal.json > /dev/null

#Run the test cases for HTML injection XSS
./ProjectTests/test-001-xss.sh


#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/html_injection.json > /dev/null
