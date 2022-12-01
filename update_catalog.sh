#!/bin/bash
cat lut_catalog.sql | sqlite3 lut_catalog.db
sqlite3 lut_catalog.db .dump > lut_catalog.sql
git commit -a -m "update"
git pull
cat lut_catalog.sql | sqlite3 lut_catalog.db
sqlite3 lut_catalog.db .dump > lut_catalog.sql
git commit -a -m "update"
git push
