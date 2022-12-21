#!/bin/bash
<<<<<<< HEAD
#sqlite3 lut_catalog.db .dump > lut_catalog.sql
#sqlite3 lut_catalog.db < lut_catalog.sql 
#git commit -a -m "update"
=======
# sqlite3 lut_catalog.db .dump > lut_catalog.sql
# sqlite3 lut_catalog.db < lut_catalog.sql 
# git commit -a -m "update"
>>>>>>> 1d5e871519eb45634a8ced7df02f2397b10216ad
git pull
sqlite3 lut_catalog.db < lut_catalog.sql 
sqlite3 lut_catalog.db .dump > lut_catalog.sql
git commit -a -m "update"
git push
