#!/bin/bash
#siege --quiet -t10S -g www.joedog.org

# Reset Color
NC='\033[0m'              # Text Reset
# Regular Colors
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White


display_usage() {
	echo -e "Script to run siege."
  echo -e "${YELLOW}The urls must be placed in the urls.txt file.${NC}"

	echo -e "\nUsage:"
        echo -e "$0 <NUM_USERS> <DELAY> <TIME>\n"
		echo -e "\nOptions:"
		echo -e "\tNUM_USERS - concurrent number of users"
		echo -e "\t   DELAY - Delay (in seconds) between each page request."
    echo -e "\t    TIME - Amount of time each user should run (3600S, 60M, 1H)\n"        
	}

# If less than two arguments supplied, display usage.
if [  $# -lt 3 ]
then
    display_usage
    exit 1
fi

NUM_USERS=$1
DELAY=$2
TIME=$3

# siege params:
#    --quiet    : This directive silences siege.
#    --log=FILE : This directive allows you to specify an alternative file for logging.)
#    -c         : Set the concurrent number of users.
#    -d         : Instructs siege how long to delay (in seconds) between each page request.
#    -i         : Internet mode. It makes requests from the urls.txt file in random order.
#    -f         : list of urls inside a text file.
#    -t         : Amount of time each user should run (-t3600S, -t60M, -t1H)

siege --quiet --log=./siege.log -c$NUM_USERS -d$DELAY -i -f urls.txt -t$TIME
if [ $? -eq 0 ] ; then
  echo "Success"
else
  echo "Failure"
fi