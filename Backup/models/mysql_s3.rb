# encoding: utf-8

##
# Backup Generated: mysql_s3
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mysql_s3 [-c <path_to_configuration_file>]
#
Backup::Model.new(:mysql_s3, 'Backup MySQL DB to S3') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

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
  # Available Regions:
  #
  #  - ap-northeast-1
  #  - ap-southeast-1
  #  - eu-west-1
  #  - us-east-1
  #  - us-west-1
  #
  store_with S3 do |s3|
    s3.access_key_id     = ENV['S3_KEY']
    s3.secret_access_key = ENV['S3_SECRET']
    s3.region            = ENV['S3_REGION'] || "us-east-1"
    s3.bucket            = ENV['S3_BUCKET']
    s3.path              = ENV['S3_PATH']   if ENV['S3_PATH']
    s3.keep              = ENV['S3_KEEP']   || Time.now - 60 * 60 * 24 * 30
  end

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_warning           = true
  #   mail.on_failure           = true
  #
  #   mail.from                 = "sender@email.com"
  #   mail.to                   = "receiver@email.com"
  #   mail.address              = "smtp.gmail.com"
  #   mail.port                 = 587
  #   mail.domain               = "your.host.name"
  #   mail.user_name            = "sender@email.com"
  #   mail.password             = "my_password"
  #   mail.authentication       = "plain"
  #   mail.encryption           = :starttls
  # end

end
