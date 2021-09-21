[//]: # (SPDX-License-Identifier: CC-BY-4.0)

## Hyperledger Fabric based PoC Blockchain

Please read the [documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/) to understand the basic concepts of Hyperledger Fabric Framework.

This project is loosely based on [this tutorial])https://medium.com/coinmonks/creating-a-hyperledger-fabric-network-from-scratch-part-i-designing-the-network-23d803bbdb61). It's recommended to skim it (lots of code dumps) to understand the basic concepts and the implementation, and useful for developing the actual use cases needed to complete this project.

## Requirements

It is required to have Docker an git installed on your machine, as well as [node](https://nodejs.org/en/download/) and [yarn](https://classic.yarnpkg.com/en/docs/getting-started)
It's recommended to use of [nvm](https://github.com/nvm-sh/nvm), a node versions manager tool. Use lts versions (>=10, >=12 have been tested and are fully working).
Information regarding basic usage of docker can be found at [Docker documentation](https://docs.docker.com/), basic knowledge of (container composing)[https://docs.docker.com/compose/] is required to understand the scripts and the YAML configuration files used to bring up the network.

Master branch should have retained the binaries. If not, we need to add a bash script that retrieves them. (develop branch has bin folder gitignored)

## Installing and running the PoC blockchain

Once you are all set with requirements, just clone this repo under your home path and run
```
  cd supply-chain-blockchain/supply-chain
  ./network.sh install
  ./network.sh start
```

You should see a bunch of logs, after api server is up, switch to another terminal tab and check that all containers and volumes are up.
```
  docker ps -a
```

Always stop the network with 
```
  ./network.sh stop
```
as it is needed to perform cleanup operations.

There is no volumes persistency: every time the network and its data are destroyed and recreated anew.

## Troubleshooting

For potential issues refer to [Troubleshooting](https://hyperledger-fabric.readthedocs.io/en/release-1.4/build_network.html#troubleshooting), open an issue in this project or contact me.

# API Doc

The api server runs on localhost:3000. use Postman or cURL to perform queries.

**AddTuna**
----
  Add new Tuna to the blockchain network

* **URL**

  `/api/addTuna`

* **Method:**
  
	`POST` 

* **Data Params**

```
  "id":integer,
  "latitude":string,
  "longitude":string,
  "length":integer,
  "weight":integer
 ``` 

* **Success Response:**
  
``` 
{	
  "status":"OK - Transaction has been submitted",
  "txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
} 
```
 
* **Sample Call:**

 ``` 
 curl --request POST \
  --url http://localhost:3000/api/addTuna \
  --header 'content-type: application/json' \
  --data '{
			"id":10001,
			"latitude":"43.3623",
			"longitude":"8.4115",
			"length":34,
			"weight":50
		   }' 
 ```
            
**getTuna**
----
  Get Tuna from the blockchain with the actual status

* **URL**

  `/api/getTuna/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
 {
    "result": {
        "id": integer
        "latitude": string
        "longitude": string
        "length": integer
        "weight": integer
    } 
 }
 ```
 
* **Sample Call:**

``` 
curl --request GET \
  --url 'http://localhost:3000/api/getTuna/<TunaId>' \
  --header 'content-type: application/json' \ 
```


**setPosition**
----
  Sets the position (latitude and longitud) for the specified id, could be sushiId or TunaId

* **URL**

  `/api/getTuna/setPosition`

* **Method:**
  
	`POST` 

* **Data Params**
``` 
"id":10001,
"latitude":"43.3623",
"longitude":"8.4115"
``` 

* **Success Response:**
  
 ``` 
{	
	status":"OK - Transaction has been submitted",
	"txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
}
 ```
 
* **Sample Call:**

``` 
curl --request POST \
  --url http://localhost:3000/api/setPosition \
  --header 'content-type: application/json' \
  --data '{
            "id":10001,
            "latitude":"43.3623",
            "longitude":"8.4115"
			}'
```

**addSushi**
----
   Add new Sushi to the blockchain network with the related TunaId

* **URL**

  `/api/getTuna/addSushi`

* **Method:**
  
	`POST` 

* **Data Params**
 ```   
"id":integer,
"latitude":string,
"longitude":string,
"type":string,
"tunaId":integer
 ``` 
* **Success Response:**
  
 ``` 
{	
	status":"OK - Transaction has been submitted",
	"txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
}
 ```
 
* **Sample Call:**

``` 
curl --request POST \
  --url http://localhost:3000/api/addSushi \
  --header 'content-type: application/json' \
  --data '{
			"id":200001,
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type":"sashimi",
            "tunaId":10001
			}'
```

**getSushi**
----
  Get sushi from the blockchain with the actual status

* **URL**

  `/api/getSushi/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
  {
    "result": {
            "id":"200001",
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type":"sashimi",
            "tunaId":10001
			}'
}
 ```
 
* **Sample Call:**
 
``` 
curl --request GET \
  --url 'http://localhost:3000/api/getSushi/<SushiId>' \
  --header 'content-type: application/json' \
```



**getSushiHistory**
----
  Get sushi history, from the TunaId that started the supply-chain, getting all the history positions, until the sushi is delivered, with the sushi history too

* **URL**

  `/api/getHistorySushi/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
{
    "historySushi": [
        {
            "id": "200001",
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type": "sashimi",
            "tunaId": 10004
        },
        {
            "id": "200001",
            "latitude":"43.3623",
            "longitude":"8.4115",
            "type": "sashimi",
            "tunaId": 10004
        }
    ],
    "historyTuna": [
        {
            "id": "10004",
            "latitude":"43.3623",
            "longitude":"8.4115",
            "length": 34,
            "weight": 50
        }
    ]
}
 ```
 
* **Sample Call:**
 
 ``` 
curl --request GET \
  --url 'http://localhost:3000/api/getHistorySushi/<SushiId>' \
  --header 'content-type: application/json' \
```


## License <a name="license"></a>

Hyperledger Project source code files are made available under the Apache
License, Version 2.0 (Apache-2.0), located in the [LICENSE](LICENSE) file.
Hyperledger Project documentation files are made available under the Creative
Commons Attribution 4.0 International License (CC-BY-4.0), available at http://creativecommons.org/licenses/by/4.0/.
