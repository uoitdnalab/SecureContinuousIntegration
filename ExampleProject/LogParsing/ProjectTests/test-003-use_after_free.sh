#	This program should be executed as ./ProjectTests/test-003-use_after_free.sh
#	not as ./test-003-use_after_free.sh


#Display line numbers for debugging output
export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer-3.5
export ASAN_OPTIONS=symbolize=1

#Get current directory
ROOT_DIR=$(pwd)

#Switch to program source code directory
cd ProjectGitRepo

#Compile the program with Clang (AddressSanitizer)
clang -fsanitize=address -g lowlevel_service.c

#Switch back to original directory
cd $ROOT_DIR

#Test for use-after-free
./ProjectGitRepo/a.out 3000 2>asan_log.log

#See if there were any errors
if [ -s asan_log.log ]
then
	#Parse AddressSanitizer log for use-after-free errors and JSONify
	python additive_log_parse.py asan_log.log ProjectGitRepo/lowlevel_service.c ProjectTests/test-003-use_after_free.sh json/use_after_free.json
else
	echo "ERROR_FREE" > asan_log.log
fi

