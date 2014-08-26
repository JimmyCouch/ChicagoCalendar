class VisitorsController < ApplicationController

	def index
	    @date = params[:month] ? Date.parse(params[:month]) : Date.today
		@events = Event.all
	end


	def add_event_to_user

		# current_user.events.new


	end

end
