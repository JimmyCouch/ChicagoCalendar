require 'net/http'
require 'socket'
require "uri"

module GoogleHelper
	
	def self.resolve_coordinates(address)
		escaped_addr = URI.escape(address)
		uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{escaped_addr}&sensor=false")
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)
		if JSON.parse(response.body)["status"].to_s == "OK"
			json_response = JSON.parse(response.body)["results"][0]["geometry"]["location"]
		else
			nil
		end
	end

end