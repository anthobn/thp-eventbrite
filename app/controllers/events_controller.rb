class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_admin_of_event?, only: [:edit, :update, :destroy]
  
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(post_params)

    flash[:success] = "L'évènement a été mis à jour avec succès !"
    redirect_to root_path
  end

  def show
    @event = Event.where(id: params['id'])[0]
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "L'évènement a été supprimé avec succès !"
    redirect_to root_path
  end

  private

  def post_params
    return params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
