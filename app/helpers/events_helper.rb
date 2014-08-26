require 'nokogiri'
require 'open-uri'
require 'active_support/all'
require 'rss'
require 'sanitize'

module EventsHelper

	def self.scrape_theater_in_chicago

		theater_url = 'http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php?ran=8&month=8&year=2014'
		page = Nokogiri::HTML(open(theater_url)) 
		event_selector = page.css(".JeffRedHead")
		title_selector = page.css(".detailhead a")
		desc_selector = page.css(".detailbody")

		event_selector.each_with_index do |event, index|

			date = Date.parse(event.text) 
			title = title_selector[index].text
			description = desc_selector[index].text.squish
			desc = description.gsub(/\d{1,2}:\d{2}(am|pm)/,"")
			time = description[/\d{1,2}:\d{2}(am|pm)/]
			url = title_selector[index]["href"]

			result_hash = {date: date, title: title, desc: desc, time: time, url: url}
			Event.create(result_hash) if !Event.exists?(title: title, desc: desc, time: time, url: url)
		end
	end

	def self.scrape_choose_chicago 
		choose_chicago_url = 'http://www.choosechicago.com/includes/cfcs/syndication/RSS/rssManager.cfc?method=showFeed&feedType=events&e_catID=0&regionid=0&e_sdate=08-01-2014&e_edate=08-31-2014'
		open(choose_chicago_url) do |rss|
		  feed = RSS::Parser.parse(rss)

		  feed.items.each do |event|

		  	title = event.title
		  	description = Sanitize.fragment(event.description)
		  	date = description[/\d{2}-\d{2}-20\d{2}/]
		  	date = Date.strptime(date, '%m-%d-%Y')
		  	desc = description.gsub(/\d{2}-\d{2}-20\d{2} to \d{2}-\d{2}-20\d{2} -/,"").gsub(/\d{2}-\d{2}-20\d{2}/,"")
		  	url = event.link

		  	result_hash = {date: date, title: title, desc: desc, url: url}
		  	Event.create(result_hash) if !Event.exists?(title: title, desc: desc, url: url)
		  end
		end
	end
end






