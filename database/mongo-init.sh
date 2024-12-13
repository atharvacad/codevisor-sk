#!/bin/bash
set -e

# Wait for MongoDB to start
sleep 5

# Import the JSON data into the projects collection
mongoimport --host localhost --db projects_db --collection projects --file /data/projects.json --jsonArray