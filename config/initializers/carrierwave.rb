CarrierWave.configure do |config|
  config.fog_credentials = {
    # Configuration for Amazon S3 should be made available through an Environment variable.
    # For local installations, export the env variable through the shell OR
    # if using Passenger, set an Apache environment variable.
    #
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    
    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET']
  }

  config.fog_directory  = 'summitup'                     # required
 
  # # For testing, upload files to local `tmp` folder.
  # if Rails.env.test? || Rails.env.development?
  #   config.storage = :file
  #   config.enable_processing = false
  #   config.root = "#{Rails.root}/tmp"
  # else
  #   config.storage = :fog
  # end

end
