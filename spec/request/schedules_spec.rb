require "rails_helper"

RSpec.describe "Schedules API", :type => :request do
  let(:user) { create(:user) }
  let!(:hospital) { create(:hospital) }
  let!(:doctor) { create(:doctor) }
  let!(:schedules) { create_list(:schedule, 20, doctor_id: doctor.id) }
  let(:hospital_id) { hospital.id }
  let(:doctor_id) { doctor.id }
  let(:id) { schedules.first.id }
  let(:headers) { valid_headers }

  describe "GET /hospitals/:hospital_id/doctors/:doctor_id/schedules" do
    before { get "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules", params: {}, headers: headers }

    context "when doctor exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all doctor schedules" do
        expect(json.size).to eq(20)
      end
    end

    context "when doctor does not exist" do
      let(:doctor_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  describe "GET /hospitals/:hospital_id/doctors/:doctor_id/schedules/:id" do
    before { get "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{id}", params: {}, headers: headers }

    context "when doctor schedule exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the schedule" do
        expect(json["id"]).to eq(id)
      end
    end

    context "when doctor schedule does not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  describe "POST /hospitals/:hospital_id/doctors/:doctor_id/schedules" do
    let(:valid_attributes) { { schedule_day: "Monday", schedule_start: Time.now, schedule_finish: Time.now }.to_json }

    context "when request attributes are valid" do
      before do
        post "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules", params: valid_attributes, headers: headers
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when an invalid request" do
      before { post "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules", params: {}, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        expect(response.body).to match(/Validation failed: Schedule day can't be blank, Schedule start can't be blank, Schedule finish can't be blank/)
      end
    end
  end

  describe "PUT /hospitals/:hospital_id/doctors/:doctor_id/schedules/:id" do
    let(:valid_attributes) { { schedule_day: "Friday" }.to_json }

    before { put "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{id}", params: valid_attributes, headers: headers }

    context "when schedules exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the schedules" do
        expect(response.body).to be_empty
      end
    end

    context "when the schedules does not exist" do
      let(:doctor_id) { 1 }
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
	end
	
  describe 'DELETE /hospitals/:hospital_id/doctors/:doctor_id/schedules/:id' do
    before { delete "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
