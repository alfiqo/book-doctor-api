class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :update, :destroy]

  # GET /hospitals
  def index
    @hospitals = Hospital.all
    json_response(@hospitals)
  end

  # POST /hospitals
  def create
    @hospital = Hospital.create!(hospital_params)
    json_response(@hospital, :created)
  end

  # GET /hospitals/:id
  def show
    json_response(@hospital)
  end

  # PUT /hospitals/:id
  def update
    @hospital.update(hospital_params)
    head :no_content
  end

  # DELETE /hospitals/:id
  def destroy
    @hospital.destroy
    head :no_content
  end

  private

  def hospital_params
    # whitelist params
    params.permit(:name, :address)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
