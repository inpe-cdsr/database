# database

You need to install [catalog](https://github.com/inpe-cdsr/catalog) repository before continuing this tutorial. This tutorial assumes you created a folder called `inpe-cdsr`, you have added [catalog](https://github.com/inpe-cdsr/catalog) inside it and you have run a `docker-compose.*.yml` file.

Clone the [this](https://github.com/inpe-cdsr/database) repository inside `inpe-cdsr` folder and get into it:

```
$ cd inpe-cdsr/ && \
git clone https://github.com/inpe-cdsr/database.git && \
cd database/
```


## MariaDB

Create the database schemas and views with the following commands:

```
$ docker exec -i inpe_cdsr_db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < db_structure/catalogo.sql

$ docker exec -i inpe_cdsr_db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < db_structure/cadastro.sql
```


## PostgreSQL

Create a backup of `cdsr_catalog` database:

```
docker exec -u postgres inpe_cdsr_postgis pg_dump -Fc cdsr_catalog > $(date +%Y_%m_%d)_cdsr_catalog.dump
```

When you restore the above backup, if there is not a `cdsr_catalog` database, then create it:

```
docker exec -u postgres inpe_cdsr_postgis createdb -T template0 cdsr_catalog
```

Restore the it inside `cdsr_catalog` database:

```
docker exec -i -u postgres inpe_cdsr_postgis pg_restore -d cdsr_catalog < $(date +%Y_%m_%d)_cdsr_catalog.dump
```
