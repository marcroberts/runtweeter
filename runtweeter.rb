require './config'

Twitter.configure do |config|
  config.consumer_key = CONFIG[:twitter][:consumer_key]
  config.consumer_secret = CONFIG[:twitter][:consumer_secret]
  config.oauth_token = CONFIG[:twitter][:oauth_token]
  config.oauth_token_secret = CONFIG[:twitter][:oauth_secret]
end


rk = Runkeeper.new 

run = rk.latest_activity

# print run.to_yaml

if run['is_live'] # only continue if he's currently running

	started = Time.parse run['start_time']

	point = run['path'].last
	distance = run['distance'].last
	miles = '%.1f' % (distance['distance'] / 1609)

	ts = started + point['timestamp']

	if (ts > Time.now - RECENCY) # last update less than 10 mins ago ?

		point_name = Geocoder.search("#{point['latitude']},#{point['longitude']}")

		address = point_name.first.data['formatted_address'].split(',').first

		text = "Gary was near #{address} at #{ts.strftime '%H:%M'}, #{miles} miles in to his run."

		map_url = URI.parse("http://maps.googleapis.com/maps/api/staticmap?center=#{point['latitude']},#{point['longitude']}&zoom=15&size=400x400&sensor=false&markers=#{point['latitude']},#{point['longitude']}")

		Twitter.update_with_media(text, open(map_url))

		LOG.info "tweeted" if DEBUG

	else

		LOG.info "old data" if DEBUG

	end

else

	LOG.info "not live" if DEBUG

end