class UsersController < ApplicationController

	def index
	    @date = params[:month] ? Date.parse(params[:month]) : Date.today
		@events = Event.all
	end


	def add_event_to_user
		@event = Event.find_by_id(params[:event_id])
		@user = User.find_by_id(current_user.id)
		if !@user.events.exists?(@event)
			@user.events << @event
		end
		redirect_to show_events_path
	end

	def show
		@event = Event.first
		@user = User.find_by_id(current_user.id)
		@date = params[:date] ? DateTime.parse(params[:date]) : DateTime.now
		if params[:view] == "day"
			@events = @user.events.where(:datetime => @date.beginning_of_day..@date.end_of_day)
		else
			@events = @user.events.where(:datetime => @date.beginning_of_month..@date.end_of_month)
		end
		@view = params[:view] || "calendar"
		render 'users/show_calendar'
	end

	def addresses
		date = Date.parse(params[:date])
		@user = User.find_by_id(current_user.id)
		@addresses = @user.events.where(:datetime => date.beginning_of_month..date.end_of_month)
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @addresses }
		  format.json { render :json => @addresses }
		end
	end

end
