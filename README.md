# PostgreSQL Copy

Image that runs a container for copying a database from one server to another.

## Environment Variables

Both `SOURCE_*` and `TARGET_*` variables must be defined for the following parameters.

- `HOST`
- `PORT`
- `USER`
- `PASS`
- `DB`

## Usage

The most concise way is to create an environment file, such as `pgcopy.vars`:

```
SOURCE_HOST=192.168.59.103
SOURCE_PORT=5433
SOURCE_DB=postgres
SOURCE_USER=postgres
TARGET_HOST=192.168.59.103
TARGET_PORT=5434
TARGET_DB=postgres
TARGET_USER=postgres
```

Then pass it to the `docker run` command. The target database will be automatically created if it does not exist.

```
docker run --env-file=pg.vars bruth/pgcopy
```

Any additional arguments passed to the command will be added to the `pg_dump` command for the source database. This provides flexibility for specifying more fine-grain options such as selecting specific schemata or tables to dump, dropping existing tables, or creating the database. For example, this command will clean all objects in the target database before copying the new data.

```
docker run --env-file=pg.vars bruth/pgcopy --clean --if-exists --schema=archive
```

See the full reference of `pg_dump` options: http://www.postgresql.org/docs/9.4/static/app-pgdump.html
