class VisitorsController < ApplicationController

	def index
	    @date = params[:month] ? Date.parse(params[:month]) : Date.today
		@events = Event.all
	end

end
