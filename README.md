# OpenProject Dockerfile

A Dockerfile that builds [OpenProject][openproject], a free and open source software for project management with a wide set of features and plugins and an active community.

Comes with Vagrantfile for local testing; just use `vagrant up --no-parallel`.

## Basic usage

This is currently relying on a linked database container.  Here's an example usage (including data-only container):

```
docker run -d --name openproject-postgres-data -v /data busybox true
docker run -d --name openproject-postgres --volumes-from openproject-postgres-data -e USER=super -e PASS=password paintedfox/postgresql
docker run -d --name openproject --link openproject-postgres:postgres -p 8080:80 abevoelker/openproject /var/www/openproject/docker/scripts/start_application.sh
```

Wait a little while for the database setup and migrations to run.  After a short period the application should be available at http://localhost:8080.  You can check the database migration progress with `docker attach openproject`.

At some point I'll make the container more configurable, to use environment variables rather than rely on linked containers.  Pull requests welcome!

## License

MIT license.

[openproject]: https://www.openproject.org/
