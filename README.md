BASS (Backup And Sync Service)
==============================

A docker-based service that allows you to backup and sync various data. The
initial release supports backing up a MySQL DB and saving it to S3.


Usage
-----

    docker pull thoom/bass
    docker run --rm -v $PWD:/backup/models thoom/bass perform -t mysql_s3 -c config.rb
