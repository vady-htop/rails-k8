#!/bin/bash

cd  /opt/app/cassandra-example-using-rails
rails cequel:keyspace:create && rails cequel:migrate
rails s -b 0.0.0.0

