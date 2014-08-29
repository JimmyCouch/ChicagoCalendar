require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'active_support/all'
require 'rss'
require 'open-uri'
require 'sanitize'
require_relative 'googlehelper'


class ScrapeTheaterInChicago
  attr_accessor :full_url, :title, :datetime, :desc, :url, :page, :address

  def initialize(date)
    month = date.month
    year = date.year

    @full_url = 'http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php' << "?ran=8&month=#{month}&year=#{year}"
    @page = get_page
    @event_selector = get_event_selector
    @title_selector = get_title_selector
    @desc_selector = get_desc_selector
  end

  def get_page
    Nokogiri::HTML(open(@full_url)) 
  end

  def title(event, index)
    @title_selector[index].text
  end

  def desc(event, index)
     url = url(event, index) 
     page = Nokogiri::HTML(open(url)) 
     inner_page_selector = page.css("table")[0]
     title = page.css("#titleP").to_s
     name = page.css("#theatreName").to_s
     about = page.css("p.detailbody")[0..3]
     about = ""
     (0..3).each { |num| about << page.css("table tr td table tr td table tr td table tr td p.detailBody")[num].to_s}
     # add the first 3 p.detailBody
     times = page.css("table.daysTable").to_s
     set_address_info(name)
     desc = title + name + about + times
  end

  def set_address_info(name)
    @address = name.squish.scan(/<br>(\s*.*)<\/p>$/).last.first
  end

  def raw_desc(event, index)
    @desc_selector[index].text.squish
  end

  def datetime(event, index)
    date = Date.parse(event.text)
    hour,minutes = raw_desc(event,index)[/\d{1,2}:\d{2}/].split(":")

    datetime = DateTime.new(date.year,date.month,date.day,hour.to_i,minutes.to_i,0,"-6")
  end

  def url(event, index)
    @title_selector[index]["href"]
  end

  def get_title_selector
    @page.css(".detailhead a")
  end

  def get_event_selector
    @page.css(".JeffRedHead")
  end

  def get_desc_selector
    @page.css(".detailbody")
  end

  def get_coords(address)
    GoogleHelper.resolve_coordinates(address)
  end

  def parse 

    events = []

    @event_selector.each_with_index do |event, index|
      puts "Adding theater in Chicago event"
      desc = desc(event,index)
      address = @address
      puts address
      if !address.nil?
        coords = get_coords(address)
        if !coords.nil?
          result_hash = {datetime: datetime(event,index), title: title(event,index), desc: desc, url: url(event,index), address: @address, lat: coords["lat"], lng: coords["lng"], source: "theaterinchicago"}
          events << result_hash
        end
      end
    end

    events
  end

end

