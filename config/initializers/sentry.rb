Raven.configure do |config|
  config.dsn = 'https://0f80ab12a9e14874be4bde25d9b38222:5b5df61bb756457bab8c9741e26d01da@sentry.io/1277454'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
