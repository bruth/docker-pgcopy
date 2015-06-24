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

The most concise way is to create an environment file, such as `pg.vars`:

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

Then pass it to the `docker run` command.

```
docker run --env-file=pg.vars bruth/pgcopy
```
