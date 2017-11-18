#! /bin/sh

# Sample Shell Script for CotEditor
#
# Wrap the selection with <h1> tags.


# ENVIRONMENT
# The document file path
# If the frontmost document has already been saved, 
# the absolute file path of the document will be referred to as an argument.
# 
# Example
# echo first argument: $1

echo "START"

#
# Check if parameter 1 exists
# It contains the filename  which should be formatted
#

echo 'CHECK: Parameter 1'
if [ "$1" ]; then
	# Not installed
	echo 'GOOD: Parameter 1 is available'
else
	# Not installed
	echo 'BAD: Parameter 1 is not available' 
	echo 'HINT: Please save your file in CotEditor and try again'
    # EXit with error
	exit 1
fi

# Get "/foo/bar/baz.php"
myFile=$1

# Get "/foo/bar"
myDir=$(dirname "$1")


# Get "bar.php"
myFilenameWithExt=$(basename "$1")

# Get "/foo/bar/baz.php"
myLog="$1.log"

echo 'HINT: See logfile for more output:'
echo "LOG : $myLog" 

echo "First param: $1" >>$myLog 2>&1
echo "myFile : $myFile" >>$myLog 2>&1
echo "myDir  : $myDir" >>$myLog 2>&1
echo "my File: $myFilenameWithExt" >>$myLog 2>&1
echo "myLog  : $myLog" >>$myLog 2>&1

# debug command
echo "which binary: " >>$myLog 2>&1
echo "command -v php-cs-fixer" >>$myLog 2>&1

#
# Check if php-cs-fixer is installed
# /usr/local/bin/php-cs-fixer
#
echo 'CHECK: php-cs-fixer' >>$myLog 2>&1
if [ command -v php-cs-fixer 2>/dev/null ]; then
	# Not installed
	echo 'GOOD: php-cs-fixer is installed' >>$myLog 2>&1
else
	# Not installed
	echo 'BAD: php-cs-fixer is not installed' >>$myLog 2>&1
	echo 'HINT: Please install php-cs-fixer' >>$myLog 2>&1	
    # EXit with error
	exit 1
fi



# With logging
# https://www.linuxquestions.org/questions/programming-9/log-bash-script-output-to-file-with-timestamp-936746/
/usr/local/bin/php-cs-fixer fix $myFile --using-cache=no >>$myLog 2>&1

# No logging
# /usr/local/bin/php-cs-fixer fix $myFile --using-cache=no

echo "END"
