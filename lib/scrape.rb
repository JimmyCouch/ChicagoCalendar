require_relative 'scrapers/scrape_theater_in_chicago'
require_relative 'scrapers/scrape_choose_chicago'


class Scrape

	attr_accessor :date, :events

	def initialize(date)
		@date = date

	end

	def get_all_events

		events_array = []

		events_array << ScrapeTheaterInChicago.new(@date).parse

		events_array << ScrapeChooseChicago.new(@date).parse

		events_array
	end

end