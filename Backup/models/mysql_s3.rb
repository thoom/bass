# encoding: utf-8

##
# Backup Generated: mysql_s3
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mysql_s3 [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:mysql_s3, 'Backup MySQL DB to S3') do

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV['MYSQL_DBNAME']   || :all
    db.username           = ENV['MYSQL_USERNAME'] || "root"
    db.password           = ENV['MYSQL_PASSWORD']
    db.host               = ENV['MYSQL_HOST']     || 'mysql.host'
    db.port               = ENV['MYSQL_PORT']     || 3306
    db.additional_options = ["--quick", "--single-transaction"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = ENV['S3_KEY']
    s3.secret_access_key = ENV['S3_SECRET']
    s3.region            = ENV['S3_REGION'] || "us-east-1"
    s3.bucket            = ENV['S3_BUCKET']
    s3.path              = ENV['S3_PATH']   if ENV['S3_PATH']
    s3.keep              = ENV['S3_KEEP']   || Time.now - 60 * 60 * 24 * 30
  end

  ##
  # Bzip2 [Compressor]
  #
  compress_with Bzip2

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_warning           = true
  #   mail.on_failure           = true
  #
  #   mail.from                 = "sender@email.com"
  #   mail.to                   = "receiver@email.com"
  #   mail.cc                   = "cc@email.com"
  #   mail.bcc                  = "bcc@email.com"
  #   mail.reply_to             = "reply_to@email.com"
  #   mail.address              = "smtp.gmail.com"
  #   mail.port                 = 587
  #   mail.domain               = "your.host.name"
  #   mail.user_name            = "sender@email.com"
  #   mail.password             = "my_password"
  #   mail.authentication       = "plain"
  #   mail.encryption           = :starttls
  # end

end
