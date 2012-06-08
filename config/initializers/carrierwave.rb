CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/"
  config.storage = :fog
  config.permissions = 0666
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJGHS3T7Q2LO4BENQ',
    :aws_secret_access_key  => '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',
  }
  config.fog_directory  = 'cheapdrunk'
end