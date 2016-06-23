#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sqlite3
from flask import Flask
from flask import request
from flask import render_template
from flask import redirect
from flask import send_from_directory

conn = sqlite3.connect(':memory:') #Use an in-memory SQL database for the sake of example
sql_cur = conn.cursor()

sql_cur.execute('CREATE TABLE website_comments(username text, comment text)') #Create the SQL table for comments
sql_cur.execute('CREATE TABLE allowed_users(username text, password text)') #Create the SQL table for storing allowed users

#Create some legitate users
sql_cur.execute('INSERT INTO allowed_users (username,password) VALUES ("hello","world")')
sql_cur.execute('INSERT INTO allowed_users (username,password) VALUES ("abc","123")')

app = Flask(__name__)

def remove_quotes(s):
	input_str = str(s)
	output_str = ""
	for c in input_str:
		if c != '"' and c != "'":
			output_str += c
	return output_str

@app.route('/')
def main_page():
	comment_section_html = "<table border=3 padding=4>"
	
	try:
		dat = sql_cur.execute('SELECT username,comment FROM website_comments')
		for obj in dat:
			comment_section_html += "<tr>"
			comment_section_html += "<td>"
			comment_section_html += "<b>"
			comment_section_html += str(obj[0])
			comment_section_html += "</b>"
			comment_section_html += "</td>"
			comment_section_html += "<td>"
			comment_section_html += str(obj[1])
			comment_section_html += "</td>"
			comment_section_html += "</tr>"
		
	except:
		pass
	
	comment_section_html += "</table>"
	
	return render_template("main.html",table_comments=comment_section_html)

@app.route('/do_math',methods=["POST"])
def do_math():
	value_x = request.form['value_x']
	return os.popen('./lowlevel_service ' + str(value_x)).read()

@app.route('/do_comment',methods=["POST"])
def do_comment():
	username = request.form['username']
	password = request.form['password']
	comment_text = request.form['comment_text']
	#Authenticate a legitimate user
	try:
		dat = sql_cur.execute('SELECT password FROM allowed_users WHERE username="' + str(username) + '"')
		print 'SELECT password FROM allowed_users WHERE username="' + str(username) + '"'
		expected_password = str(dat.next()[0])
		if str(password) == expected_password:
			#Insert comment into SQL table
			sql_cur.execute('INSERT INTO website_comments (username,comment) VALUES ("' + remove_quotes(username) + '"," ' + remove_quotes(comment_text) + '")')
	except:
		return redirect("/")
		
	return redirect("/")

@app.route('/get_file/<path:fname>')
def get_file(fname):
	f = open(fname)
	file_data = f.read()
	f.close()
	return file_data

if __name__ == '__main__':
	app.run()
