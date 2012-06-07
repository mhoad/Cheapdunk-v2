class VenuesController < ApplicationController

  load_and_authorize_resource

  layout "venue", :except => [:show]

  add_breadcrumb "Homepage", :root_path
  add_breadcrumb "Venues", :venues_path, :title => "Sydney Bars & Pubs"



  def index

    @search = Venue.search do
      fulltext params[:search]
      paginate(:page => params[:page], :per_page => 10)
    end
    @venues = @search.results
  end

  def show
    if request.path != venue_path(@venue)
      redirect_to @venue, status: :moved_permanently
    else
      @venue = Venue.find(params[:id])
      render :layout => "show_venue"
    end
  end

  def new
    @venue = Venue.new
    @venue.trading_times.new 
    @venue.specials.new
  end

  def create
    @venue = Venue.new(params[:venue])
    if @venue.save
      flash[:success] = "Venue sucessfully added"
      redirect_to @venue
    else
      render 'new'
    end
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update_attributes(params[:venue])
      flash[:success] = "Venue updated"
      redirect_to @venue
    else
      render 'edit'
    end
  end

end
