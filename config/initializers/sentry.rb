if Rails.env.production?
  Raven.configure do |config|
    config.dsn = 'https://cfd3a4857821462c98a070486ccd17d0:854d4d5eb3154f96ba275ed2c43d9434@sentry.io/1390944'
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
