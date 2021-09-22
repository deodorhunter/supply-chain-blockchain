#!/bin/bash


# Print the usage message
function printHelp() {
  echo "Usage: "
  echo "  network.sh <mode>"
  echo "    <mode> - one of 'start', 'stop', 'install'"
  echo "      - 'start' - bring up the network with docker-compose up"
  echo "      - 'stop' - clear the network with docker-compose down"
  echo "      - 'install' - install node_modules and js packages"
  echo "  network.sh -h (print this message)"
  echo
  echo "Typically, one would first generate the required certificates and "
  echo "genesis block and start the network, then bring up the api server. e.g.:"
  echo
  echo "    nestwork.sh start"
  echo
  echo "To stop the network (and to upgrade chaincode or configuration): "
  echo "	network.sh stop"
  echo

}
START_API_SERVER=false
MODE="$1"


if [ "$MODE" == "start" ]; then
    echo "***********************************"
    echo "       Generating artifacts        "
    echo "***********************************"
    ./supply-network/scripts/generate.sh
    echo "***********************************"
    echo "       Starting network            "
    echo "***********************************"
    ./supply-network/scripts/start.sh
    echo "***********************************"
    echo "       Installing chaincodes       "
    echo "***********************************"
    ./supply-network/scripts/install-cc.sh
    echo "***********************************"
    echo "       Registering users           "
    echo "***********************************"
    ./supply-network/scripts/register-users.sh
    echo "***********************************"
    echo "       Container information       "
    echo "***********************************"
    docker ps
    if [ $START_API_SERVER = true ]; then
        echo "Starting api server"
        ./supply-network/scripts/startAPIServer.sh
    else
        echo ""
        echo "***********************************"
        echo "       ALL DONE! :)      "
        echo "***********************************"
        echo
        echo "Run ./supply-network/scripts/startAPIServer.sh to start API server"
        chmod +x ./supply-network/scripts/startAPIServer.sh
    fi
elif [ "$MODE" == "stop" ]; then
    ./supply-network/scripts/stop.sh
elif [ "$MODE" == "install" ]; then
    cd ./chaincode
    yarn
    cd ..
    yarn
fi
