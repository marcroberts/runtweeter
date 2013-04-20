class Runkeeper
  include HTTParty
  base_uri 'https://api.runkeeper.com:443'
  format :json
  headers 'Authorization' => "Bearer #{CONFIG[:runkeeper][:access_token]}"


  def latest_activity
  	activites = self.class.get '/fitnessActivities'
  	latest = activites['items'].first['uri']

  	self.class.get latest
  end

end