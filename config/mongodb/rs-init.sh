#!/bin/bash

mongo <<EOF
var config = {
    "_id": "rs0",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongodb:27017",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
use realmName1;
db.createUser(
  {
    user: 'user001',
    pwd: 'pwd001',
    roles: [
      {
        role: 'readWrite',
        db: 'realmName1'
      }
    ]
  }
);
EOF