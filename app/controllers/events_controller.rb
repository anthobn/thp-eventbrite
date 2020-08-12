class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def create
    @event = Event.new(post_params)
    @event.user_admin = current_user

    if @event.save
      redirect_to event_path(@event.id)
    else
      render :new
    end

  end
  def show
    @event = Event.where(id: params['id'])[0]
  end

  private

  def post_params
    return params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
