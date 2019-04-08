# # register services
#
# WebValve.register FakeThing
# WebValve.register FakeExample, url: 'https://api.example.org'
#
# # whitelist urls
#
# WebValve.whitelist_url 'https://example.com'
WebValve.register FakeEasyPost, url: 'https://api.easypost.com'

WebValve.whitelist_url 'https://fcm.googleapis.com'
