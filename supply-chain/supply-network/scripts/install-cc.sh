#!/bin/bash

echo "Installing chaincode for producer1..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 producer1 Producer1MSP 7051 1.0
echo "Installing chaincode for manufacturer..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 manufacturer ManufacturerMSP 9051 1.0
echo "Installing chaincode for producer2..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 producer2 Producer2MSP 10051 1.0
echo "Installing chaincode for retailer..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 retailer RetailerMSP 11051 1.0
echo "Instanciating the chaincode..."
docker exec -it cli ./scripts/install-cc/instanciate.sh
