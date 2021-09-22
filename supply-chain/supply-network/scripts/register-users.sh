#!/bin/bash

node src/enrollAdmin.js producer1
node src/enrollAdmin.js manufacturer
node src/enrollAdmin.js producer2
node src/enrollAdmin.js retailer

node src/registerUser.js producer1
node src/registerUser.js manufacturer
node src/registerUser.js producer2
node src/registerUser.js retailer

