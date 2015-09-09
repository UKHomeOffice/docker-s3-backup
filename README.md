# docker-archive


So this is how we do backups.

It looks at the share dir for a configureable named file; "*.tar.gz" by default.
GPG the file
Uploads to s3.

Runs in a cruddy while loop.
