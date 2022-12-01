# Catalog of approximate LUTs for [pyALS](https://github.com/SalvatoreBarone/pyALS) and [pyALS-RF](https://github.com/SalvatoreBarone/pyALS-RF)

In order to obtain the catalog, you must run 
```
./import.sh
```
then, you must copy the ```lut_catalog.db``` file to the [pyALS](https://github.com/SalvatoreBarone/pyALS) and/or [pyALS-RF](https://github.com/SalvatoreBarone/pyALS-RF) directories.

## Updating the catalog
To ensure the catalog is up to date, run
```
./update_catalog.sh
```


## Managinbg SQLite3 Database in git

When the database is changing as new results arrived and are being processed, it is important to track its changes in case of manual or programming errors.

SQLite stores its database in a pretty complex format [described here](https://www.sqlite.org/fileformat2.html). While diffing two SQLite databases can sometimes be human-readable, this entirely depends on the binary that happens to fall right around the modified values. It's doable but sometimes requires a lot of annoying horizontal scrolling past screenfuls of control characters. Life's too short for that.

SQLite can dump entire databases out as SQL statements, and Git can be configured to do this when generating diffs. 
In a .gitattributes or .git/info/attributes file, give Git a filename pattern and the name of a diff driver, which we'll define next. In my case, I added:
```
db.sqlite3 diff=sqlite3
```
Then in .git/config or $HOME/.gitconfig, define the diff driver. Mine looks like:
```
[diff "sqlite3"]
    textconv = dumpsqlite3
```
I chose to define an external dumpsqlite3 script, since this can be useful elsewhere. It just dumps SQL to stdout for the filename given by its first argument:
```
#!/bin/sh
sqlite3 $1 .dump
```
At this point, git diff should show you plain-text diffs, as should browsing Git commits. There's still one problem left: sometimes SQLite's binary database will change, but the actual database contents remain the same. This results in a git status that says the database has changed but a git diff that says it hasn't.

I don't know enough about SQLite to know why this happens. I thought it was because SQLite doesn't compact free space right away in its database files, but I ran into a case where even if I vacuum two database files with identical contents, they still have different binaries.

One brute solution would be to dump the database contents to SQL and read them back into a "fresh" SQLite database. This should result in a canonical binary database, since SQLite doesn't seem to store anything like a timestamp in there. I suspect you could have your diff driver do this automatically every time it runs, but I haven't tried it yet.

