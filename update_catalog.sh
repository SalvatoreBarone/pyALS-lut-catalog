#!/bin/bash
./import.sh
./export.sh
git commit -a -m "update"
git pull
./import.sh
./export.sh
git commit -a -m "update"
git push
