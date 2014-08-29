require 'open-uri'
require 'active_support/all'
require 'rss'
require 'sanitize'
require 'nokogiri'
require 'open-uri'
require_relative 'googlehelper'



class ScrapeChooseChicago

	attr_accessor :full_url, :title, :datetime, :desc, :url, :inner_page, :address

	def initialize(date)
		beginning_of_month = date.at_beginning_of_month
		end_of_month = date.at_end_of_month
		@full_url = "http://www.choosechicago.com/includes/cfcs/syndication/RSS/rssManager.cfc?method=showFeed&feedType=events&e_catID=0&regionid=0&e_sdate=#{beginning_of_month}&e_edate=#{end_of_month}"
	end

	def title(event)
		event.title
	end

	def desc(page, event)
		initial_desc = Sanitize.fragment(event.description).gsub(/\d{2}-\d{2}-20\d{2} to \d{2}-\d{2}-20\d{2} -/,"").gsub(/\d{2}-\d{2}-20\d{2}/,"")
		initial_desc << page.css("div.postText").to_s
	end

	def datetime(event)
		tmp_desc = Sanitize.fragment(event.description)[/\d{2}-\d{2}-20\d{2}/]
		Date.strptime(tmp_desc,'%m-%d-%Y')
	end

	def url(event)
		event.link
	end

	def inner_page(event)
		url = url(event) 
		Nokogiri::HTML(open(url)) 
	end

	def get_address(page, event)
		page.css("div.address").text.squish
	end

	def get_coords(address)
    	GoogleHelper.resolve_coordinates(address)
	end


	def parse
    	events = []

		open(@full_url) do |rss|
		  feed = RSS::Parser.parse(rss)
		  feed.items.each do |event|
		  	inner_page = inner_page(event)
		  	address = get_address(inner_page, event)
		  	desc = desc(inner_page, event)
		  	if !address.nil?
			  	coords = get_coords(address)
			  	if !coords.nil?
				  	result_hash = {datetime: datetime(event), title: title(event), desc: desc, url: url(event), address: address, lat: coords["lat"], lng: coords["lng"], source: "choosechicago"}
				  	events << result_hash
				end
			end
		  end
		end
		events
	end
end