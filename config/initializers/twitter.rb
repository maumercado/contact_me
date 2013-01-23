Twitter.configure do |config|
  config.consumer_key = ENV['TW_KEY']
  config.consumer_secret = ENV['TW_SECRET']
  config.oauth_token = ENV['TW_O_TOKEN']
  config.oauth_token_secret = ENV['TW_O_SECRET']
end