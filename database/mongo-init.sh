#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Import the JSON data into MongoDB
mongoimport --host localhost --db projects_db --collection projects --type json --file /data/projects.json --jsonArray