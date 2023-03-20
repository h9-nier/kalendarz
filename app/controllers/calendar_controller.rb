class CalendarController < ApplicationController
    before_action :set_active_week, :authenticate_user!

    def index
        @active_week = ActiveWeek.last
        @reservations_this_week = Reservation.where(date: Date.today.beginning_of_week..Date.today.end_of_week)
    end

    def update
        @active_week = ActiveWeek.find(params[:active_week][:id])
        if @active_week.update(active_week_params)
            flash[:notice] = "Rozkład tygodnia zaktualizowany!"
            redirect_to calendar_path
        else
            flash[:notice] = "Rozkład tygodnia nie został zaktualizowany!"
            redirect_to calendar_path    
        end

    end

    private

    def active_week_params 
        params.require(:active_week).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :step, :start_time, :end_time)
    end

    # funkcja sprawiająca że aplikacja zawsze działa na biezącym tygodniu
    # funkcja usuwa przeszłe rezerwacje na początku nowego tygodnia
    def set_active_week
        if ActiveWeek.last
            if ActiveWeek.last.first_day != Date.today.beginning_of_week
                ActiveWeek.new.save
                Reservation.where("date < ?", Date.today.beginning_of_week).destroy_all
            end
        else
            ActiveWeek.new.save
        end 
    end

end