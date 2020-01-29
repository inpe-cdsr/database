# database

You need to install [catalog](https://github.com/inpe-cdsr/catalog) repository before continuing this tutorial. This tutorial assumes you created a folder called `inpe-cdsr`, you have added [catalog](https://github.com/inpe-cdsr/catalog) inside it and you have run a `docker-compose.*.yml` file.

Clone the [this](https://github.com/inpe-cdsr/database) repository inside `inpe-cdsr` folder and get into it:

```
$ cd inpe-cdsr/ && \
git clone https://github.com/inpe-cdsr/database.git && \
cd database/
```

Create the database schemas and views with the following commands:

```
$ docker exec -i inpe_cdsr_db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < db_structure/catalogo.sql

$ docker exec -i inpe_cdsr_db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < db_structure/cadastro.sql
```
