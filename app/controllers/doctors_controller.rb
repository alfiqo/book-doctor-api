class DoctorsController < ApplicationController
  before_action :set_hospital
  before_action :set_hospital_doctor, only: [:show, :update, :destroy]

  # GET /hospitals/:hospital_id/doctors
  def index
    json_response(@hospital.doctors)
  end

  # GET /hospitals/:hospital_id/doctors/:id
  def show
    json_response(@doctor)
  end

  # POST /hospitals/:hospital_id/doctors
  def create
    @hospital.doctors.create!(doctor_params)
    json_response(@hospital, :created)
  end

  # PUT /hospitals/:hospital_id/doctors/:id
  def update
    @doctor.update(doctor_params)
    head :no_content
  end

  # DELETE /hospitals/:hospital_id/doctors/:id
  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def doctor_params
    params.permit(:name, :specialization)
  end

  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end

  def set_hospital_doctor
    @doctor = @hospital.doctors.find_by!(id: params[:id]) if @hospital
  end
end
