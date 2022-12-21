#!/bin/bash
# sqlite3 lut_catalog.db .dump > lut_catalog.sql
# sqlite3 lut_catalog.db < lut_catalog.sql 
# git commit -a -m "update"
git pull
sqlite3 lut_catalog.db < lut_catalog.sql 
sqlite3 lut_catalog.db .dump > lut_catalog.sql
git commit -a -m "update"
git push
