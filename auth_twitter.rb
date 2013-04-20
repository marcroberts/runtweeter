require './config'

CONSUMER_KEY = CONFIG[:twitter][:consumer_key]
CONSUMER_SECRET = CONFIG[:twitter][:consumer_secret]

consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => true)

request_token = consumer.get_request_token

print "Please visit http://api.twitter.com/oauth/authorize?oauth_token=#{request_token.token}\n"
print "Enter the code returned\n\n> "

code = gets

access_token = request_token.get_access_token(:oauth_verifier => code.chomp )
print "access_token: #{access_token.token}, access_secret: #{access_token.secret}\n"