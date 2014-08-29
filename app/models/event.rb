class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	validates :title, uniqueness: true
	validates :datetime, presence: true


	def to_ics
	    event = Icalendar::Event.new
	    event.dtstart = self.datetime.strftime("%Y%m%dT%H%M%S")
	    event.summary = ActionView::Base.full_sanitizer.sanitize(self.desc)
	    event.description = "#{self.desc} \n Affiliated Link: #{ENV["SITE_URL"]}/events/#{self.id}"
	    event.ip_class = "PUBLIC"
	    event
	end

	def self.ical_from(these_events)
		calendar = Icalendar::Calendar.new
		these_events.each {|eventt| calendar.add_event(eventt.to_ics)}
		calendar.publish
		calendar.to_ical
	end

end
