class CalendarController < ApplicationController

	def export
		@user = User.find_by_id(current_user.id)
		@events = @user.events.all
		respond_to do |format|
     	 	format.html
      		format.ics {render :text => Event.ical_from(@events)}
    	end
	end
end
