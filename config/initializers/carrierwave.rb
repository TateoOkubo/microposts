CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id:    'AKIAIEWEZNEFWLFYMYSQ',
    aws_secret_access_key:   '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',
    region:                  'ap-northeast-1',

  }
  
  config.fog_directory = 'micropost-okubo'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/micropost-okubo'

  #case Rails.env
  #  when 'production'
  #    config.fog_directory = 'micropost-okubo'
  #    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/micropost-okubo'

  #  when 'development'
  #    config.fog_directory = 'micropost-okubo'
  #    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/micropost-okubo'

  #  when 'test'
  #    config.fog_directory = 'test.dummy'
  #    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/test.dummy'
  #end
  
end
