# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
set :output, {:error => '/Users/jcouch/Documents/git/ChicagoCalendar/log/cron_error.log', :standard => '/Users/jcouch/Documents/git/ChicagoCalendar/log/cron_status.log'}
set :job_template, "bash -i -c ':job'"
env :PATH, ENV['PATH']
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.minute do
	command "echo $RAILS_ENV" 
	# command 'rvm use ruby-2.1.2'
	runner "EventsHelper.scrape_theater_in_chicago", environment => "development"
end