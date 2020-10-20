class AppointmentsController < ApplicationController
  before_action :set_schedule
  before_action :set_schedule_appointment, only: [:show, :update, :destroy]

  def index
    json_response(@schedule.appointments)
  end

  def show
    json_response(@schedule)
  end

  def create
    @schedule.appointments.create!(schedule_params)
    json_response(@schedule.appointments, :created)
  end

  def update
    @schedule.update(schedule_params)
    head :no_content
  end

  def destroy
    @schedule.destroy
    head :no_content
  end

  private

  def schedule_params
    params.permit(:queue, :user_id, :schedule_id)
  end

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def set_schedule_appointment
    @schedule = @schedule.appointments.find_by!(id: params[:id]) if @schedule
  end
end
