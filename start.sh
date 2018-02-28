#!/bin/bash

export PORT=5102

cd ~/www/task_tracker
./bin/task_tracker stop || true
./bin/task_tracker start
