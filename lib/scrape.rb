require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'active_support/all'
require 'rss'
require 'open-uri'
require 'sanitize'

PAGE_URL = 'http://www.choosechicago.com/includes/cfcs/syndication/RSS/rssManager.cfc?method=showFeed&feedType=events&e_catID=0&regionid=0&e_sdate=08-12-2014&e_edate=08-18-2014'


open('public/file.xml') do |rss|
  feed = RSS::Parser.parse(rss)

  feed.items.each do |event|

  	title = event.title
  	description = Sanitize.fragment(event.description)
  	date = description[/\d{2}-\d{2}-20\d{2}/]
  	# date = Date.parse(date.to_s)
  	date = Date.strptime(date, '%m-%d-%Y')
  	desc = description.gsub(/\d{2}-\d{2}-20\d{2} to \d{2}-\d{2}-20\d{2} -/,"").gsub(/\d{2}-\d{2}-20\d{2}/,"")
  	url = event.link

    puts "event: #{date}"
    puts " "
  end
end

