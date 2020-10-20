class AppointmentsController < ApplicationController
  before_action :set_doctor
  before_action :set_doctor_appointment, only: [:show, :update, :destroy]

  def index
    json_response(@doctor.appointments)
  end

  def show
    json_response(@doctor)
  end

  def create
    @doctor.appointments.create!(schedule_params)
    json_response(@doctor.appointments, :created)
  end

  def update
    @doctor.update(schedule_params)
    head :no_content
  end

  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def schedule_params
    params.permit(:queue, :user_id, :doctor_id)
  end

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_doctor_appointment
    @doctor = @doctor.appointments.find_by!(id: params[:id]) if @doctor
  end
end
