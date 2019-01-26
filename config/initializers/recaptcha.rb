if Rails.env.development?
  Recaptcha.configure do |config|
    config.site_key = ENV['RECAPTCHA_SITE_KEY']
    config.secret_key = ENV['RECAPTCHA_SECRET_KEY']
  end
elsif Rails.env.production?
  Recaptcha.configure do |config|
    config.site_key = Rails.application.credentials.recaptcha_site_key
    config.secret_key = Rails.application.credentials.recaptcha_secret_key
    # Uncomment the following line if you are using a proxy server:
    # config.proxy = 'http://myproxy.com.au:8080'
  end
end
# ref.
#   http://tango-ruby.hatenablog.com/entry/2016/01/21/191706
#   https://github.com/ambethia/recaptcha
