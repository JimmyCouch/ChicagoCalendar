s = Rufus::Scheduler.singleton


# Stupid recurrent task...
#
s.every '1d' do

  Rails.logger.info "hello, it's theater"
  EventsHelper.scrape_theater_in_chicago
end

s.every '1d' do

  Rails.logger.info "hello, it's choose chicago "
  EventsHelper.scrape_choose_chicago
end