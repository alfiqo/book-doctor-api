require "rails_helper"

RSpec.describe "Appointments API", :type => :request do
  let(:user) { create(:user) }
  let!(:hospital) { create(:hospital) }
  let!(:doctor) { create(:doctor) }
  let!(:schedule) { create(:schedule) }
  let!(:appointments) { create_list(:appointment, 10, schedule_id: schedule.id, user_id: user_id) }
  let(:hospital_id) { hospital.id }
  let(:doctor_id) { doctor.id }
  let(:id) { appointments.first.id }
  let(:headers) { valid_headers }
  let(:user_id) { user.id }
  let(:schedule_id) { schedule.id }

  describe "GET /hospitals/:hospital_id/doctors/:doctor_id/schedules/:schedule_id/appointments" do
    before { get "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments", params: {}, headers: headers }

    context "when schedule exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all schedule appointments" do
        expect(json.size).to eq(10)
      end
    end

    context "when schedule does not exist" do
      let(:schedule_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  describe "GET /hospitals/:hospital_id/doctors/:doctor_id/schedules/:schedule_id/appointments/:id" do
    before { get "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments/#{id}", params: {}, headers: headers }

    context "when doctor appointment exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the appointment" do
        expect(json["id"]).to eq(id)
      end
    end

    context "when doctor appointment does not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  describe "POST /hospitals/:hospital_id/doctors/:doctor_id/schedules/:schedule_id/appointments" do
    let(:valid_attributes) { { queue: "A100", user_id: user_id, schedule_id: schedule_id }.to_json }

    context "when request attributes are valid but the records greater than 10" do
      before do
        post "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments", params: valid_attributes, headers: headers
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
        
      end
    end

    context "when an invalid request" do
      before { post "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments", params: {}, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        expect(response.body).to match(/Validation failed: Queue can't be blank, User can't be blank/)
      end
    end
  end

  describe "PUT /hospitals/:hospital_id/doctors/:doctor_id/schedules/:schedule_id/appointments/:id" do
    let(:valid_attributes) { { schedule_id: 2 }.to_json }

    before { put "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments/#{id}", params: valid_attributes, headers: headers }

    context "when appointments exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the appointments" do
        expect(response.body).to be_empty
      end
    end

    context "when the appointments does not exist" do
      let(:schedule_id) { 1 }
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  describe 'DELETE /hospitals/:hospital_id/doctors/:doctor_id/schedules/:schedule_id/appointments/:id' do
    before { delete "/hospitals/#{hospital_id}/doctors/#{doctor_id}/schedules/#{schedule_id}/appointments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
