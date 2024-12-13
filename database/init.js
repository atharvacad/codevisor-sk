// Switch to the desired database (it will be created if it doesn't exist)
db = db.getSiblingDB('projects_db');

// Create the collection if it doesn't exist
db.createCollection('projects');