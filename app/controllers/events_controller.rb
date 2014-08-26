class EventsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:update]
	def index
	    @event = Event.find_by_id(1)
	    if !params[:date].nil?
	    	@date = Date.parse(params[:date])
		elsif !params[:day].nil?
			@day = params[:day]
		else
			@date = Date.today
		end

		if params[:sources].nil?
			@events = Event.all
		else
			sources = params[:sources].split(",")
			@events = Event.where(:source => sources)
		end

		if params[:view].nil? || params[:view] == "calendar"
			@view = "calendar"
		else
			@view = params[:view]
			@events = Event.where(:datetime => @date.beginning_of_day..@date.end_of_day)
		end

	  end

	  def today
	  	@date = Date.today
	    @event = Event.find_by_id(1)
	    @events = Event.where(:datetime => @date.beginning_of_day..@date.end_of_day)
	    @view = "day"
	  	render 'events/index'
	  end
	  
	  def show
	  	@events = Event.all
	    @event = Event.find(params[:id])
	    @date = Date.parse(@event.datetime.to_s)
	    @view = "event"
	    # respond_with @event 
	    respond_to do |format|
	      format.html { render 'index'}
	      format.xml  { render :xml => @event }
	      format.json { render :json => @event }
	    end
	  end
	  
	  def new
	    @event = Event.new
	  end
	  
	  def create
	    @event = Event.new(params[:event])
	    if @event.save
	      flash[:notice] = "Successfully created event."
	      redirect_to @event
	    else
	      render :action => 'new'
	    end
	  end
	  
	  def edit
	    @event = Event.find(params[:id])
	  end
	  
	  def update
	    @event = Event.find(params[:id])
	    if @event.update_attributes(params[:event])
	      flash[:notice] = "Successfully updated event."
	      redirect_to @event
	    else
	      render :action => 'edit'
	    end
	  end
	  
	  def destroy
	    @event = Event.find(params[:id])
	    @event.destroy
	    flash[:notice] = "Successfully destroyed event."
	    redirect_to events_url
	  end

	  def addresses 
	  	date = Date.parse(params[:date])
	  	@addresses = Event.where(:datetime => date.beginning_of_month..date.end_of_month)
	  	respond_to do |format|
	  	  format.html # show.html.erb
	  	  format.xml  { render :xml => @addresses }
	  	  format.json { render :json => @addresses }
	  	end
	  end

end
