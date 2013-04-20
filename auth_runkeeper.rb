require './config'

url = HealthGraph.authorize_url



print "Please visit #{url}\n"
print "Enter the code returned\n\n> "

code = gets

access_token = HealthGraph.access_token(code)

print access_token.inspect