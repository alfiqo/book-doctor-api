class SchedulesController < ApplicationController
  before_action :set_doctor
  before_action :set_doctor_schedule, only: [:show, :update, :destroy]

  def index
    json_response(@doctor.schedules)
  end

  def show
    json_response(@schedule)
  end

  def create
    @doctor.schedules.create!(schedule_params)
    json_response(@doctor.schedules, :created)
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
    params.permit(:schedule_day, :schedule_start, :schedule_finish)
  end

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_doctor_schedule
    @schedule = @doctor.schedules.find_by!(id: params[:id]) if @doctor
  end
end
