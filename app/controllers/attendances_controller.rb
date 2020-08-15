class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_of_event?, only: [:show]

  def new
    @attendance = Attendance.new
    @event = Event.find(params['event_id'])
  end
  
  def create
    @event = Event.find(params[:eventid])

    if @event.is_free?
      Attendance.create(user: current_user, event: @event)
      flash[:success] = "Vous êtes désormais inscrit à l'évènement #{@event.title}"
      redirect_to event_path(@event.id)

    else
      
      @amount = @event.price * 100

      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      begin
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'eur',
        })

        Attendance.create(stripe_customer_id: customer.id, user: current_user, event: @event)
        flash[:success] = "Vous êtes désormais inscrit à l'évènement #{@event.title}"
        redirect_to event_path(@event.id)

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_attendance_path
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
