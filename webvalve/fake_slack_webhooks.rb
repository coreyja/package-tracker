class FakeSlackWebhooks < WebValve::FakeService
  # # define your routes here
  #
  # get '/widgets' do
  #   json result: 'it works!'
  # end
  #
  # # set the base url for this API via ENV
  #
  # export SLACKWEBHOOKS_API_URL='http://whatever.dev'
  #
  # # toggle this service on via ENV
  #
  # export SLACKWEBHOOKS_ENABLED=true

  post '/services/:id/:other_id/:third_id' do
    json 'ok'
  end
end
