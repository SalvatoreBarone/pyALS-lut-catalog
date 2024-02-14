#!/bin/bash
git pull
sqlite3 lut_catalog.db < lut_catalog.sql 
