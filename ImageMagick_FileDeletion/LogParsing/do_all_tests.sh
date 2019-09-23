#This file is part of Security Focused Continuous Integration (SFCI)
#Submitted to MDPI Computers

#Run the first test case
./ProjectTests/test-001-path_traversal.sh

#After the tests are done, serve the JSON file
#(listing the vulnerabilities) with netcat

nc -l -p 9000 -q 0 < json/path_traversal.json > /dev/null


