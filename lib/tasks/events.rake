require_relative '../scrape'

namespace :events do
  desc "Parse the available scrapers for events"
  task update: :environment do

  	date = Date.today
  	events_array_of_hashes = Scrape.new(date).get_all_events

  	events_array_of_hashes.each do |events_array|
  		events_array.each { |event| Event.create(event) if !Event.exists?(title: event[:title], url: event[:url])}
  	end
  end
end
