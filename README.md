# docker-archive

[![Build Status](https://travis-ci.org/UKHomeOffice/docker-archive.svg?branch=master)](https://travis-ci.org/UKHomeOffice/docker-archive)

So this is how we do backups.

It looks at the share dir for a configureable named file; "*.tar.gz" by default.
GPG the file
Uploads to s3.

Runs in a cruddy while loop.
