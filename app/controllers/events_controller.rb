class EventsController < ApplicationController
	def index
	    @events = Event.all

	    if !params[:date].nil?
	    	@date = Date.parse(params[:date])
		elsif !params[:day].nil?
			@day = params[:day]
		else
			@date = Date.today
		end

		if params[:view].nil? || params[:view] == "calendar"
			@view = "calendar"
		elsif params[:view] == "map"
			@view = "map"
		end


	  end
	  
	  def show
	    @event = Event.find(params[:id])
	    respond_to do |format|
	      format.html # show.html.erb
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
end
