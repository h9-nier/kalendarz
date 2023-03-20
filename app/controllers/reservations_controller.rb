class ReservationsController < ApplicationController
include ApplicationHelper
    before_action :authenticate_user!

    def index
        if !current_user_admin?
            @reservations = current_user.reservations
        else
            @confirmed_reservations = Reservation.where(confirmed: true)
            @unconfirmed_reservations = Reservation.where(confirmed: false)
        end
    end

    def new
        @reservation = Reservation.new
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id

        collision_check = Reservation.where(date: Date.today)
        if collision_check.any? { |r| r.start_time == @reservation.start_time }
            flash[:notice] = "Nie możesz się zapisać na ten termin!"
            redirect_to dashboard_path
            return
        end
        
        if @reservation.save   
            flash[:notice] = "Reservation created successfully!"
            redirect_to root_path
        else
            flash[:notice] = "Reservation error!"
            redirect_to root_path
        end

    end

    def confirm
        @reservation = Reservation.find(params[:reservation])
        @reservation.confirmed = true

        

        if @reservation.save   
            flash[:notice] = "Reservation accepted!"
            redirect_to root_path
        else
            flash[:notice] = "Reservation confirmation error!"
            redirect_to root_path
        end
    end

    def decline
        @reservation = Reservation.find(params[:reservation])

        if @reservation.destroy   
            flash[:notice] = "Reservation declined!"
            redirect_to root_path
        else
            flash[:notice] = "Reservation declination error!"
            redirect_to root_path
        end
    end

    private

    def reservation_params
        params.require(:reservation).permit(:phone_number, :email, :date, :start_time, :end_time)
    end
    
end