#!/bin/bash

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
	echo "Script to run GoldenEye HTTP DoS Test Tool."
  echo -e "  ${YELLOW}Make sure to add goldeneye in BIN PATH.${NC}"
  echo -e "  ${WHITE}$ ln -s <path-goldeneye.py> ~/.local/bin/goldeneye${NC}"

	echo -e "\nUsage:"
        echo -e "\t $0 <HOST> <WORKERS> <SOCKETS> <TIMEOUT>\n"
		echo -e "\nOptions:"
    echo -e "\t   HOST - Host under attack."
    echo -e "\tWORKERS - Number of concurrent workers"
    echo -e "\tSOCKETS - Number of concurrent sockets."
		echo -e "\tTIMEOUT - Amount of time it should run [10s, 30m, 1h, 1d]. 0 runs indefinitely. \n"
  }

# If less than two arguments supplied, display usage.
if [  $# -lt 4 ]
then
    display_usage
    exit 1
fi

DST_HOST=$1
WORKERS=$2
SOCKETS=$3
TIMEOUT=$4

TIMEOUT_CMD=""

if [ "$TIMEOUT" != "0" ]; then
  TIMEOUT_CMD="timeout -s SIGINT $TIMEOUT"
fi


# goldeneye params:
#     -u, --useragents       File with user-agents to use                            (default: randomly generated)
#     -w, --workers          Number of concurrent workers                            (default: 10)
#     -s, --sockets          Number of concurrent sockets                            (default: 500)
#     -m, --method           HTTP Method to use 'get' or 'post'  or 'random'         (default: get)
#     -n, --nosslcheck       Do not verify SSL Certificate                           (default: True)
#     -d, --debug            Enable Debug Mode [more verbose output]                 (default: False)

$TIMEOUT_CMD goldeneye $DST_HOST -w $WORKERS -s $SOCKETS
