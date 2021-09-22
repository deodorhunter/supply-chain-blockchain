#!/bin/bash

# function trap_ctrlc ()
# {
#     # perform cleanup here
#     echo "Ctrl-C caught...performing clean up"

#     echo "Doing cleanup"

#     # exit shell script with error code 2
#     # if omitted, shell script will continue execution
#     ./stop.sh
#     exit INT
# }

# # initialise trap to call trap_ctrlc function
# # when signal 2 (SIGINT) is received
# trap "trap_ctrlc" INT

echo "***********************************"
echo "       Starting API server         "
echo "***********************************"
yarn start
