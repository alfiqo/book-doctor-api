require 'rails_helper'

RSpec.describe 'Doctors API', :type => :request do
  let(:user) { create(:user) }
  let!(:hospital) { create(:hospital) }
  let!(:doctors) { create_list(:doctor, 20, hospital_id: hospital.id) }
  let(:hospital_id) { hospital.id }
  let(:id) { doctors.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /hospitals/:hospital_id/doctors
  describe 'GET /hospitals/:hospital_id/doctors' do
    before { get "/hospitals/#{hospital_id}/doctors", params: {}, headers: headers }

    context 'when hospital exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all hospital doctors' do
        expect(json.size).to eq(20)
      end
    end

    context 'when hospital does not exist' do
      let(:hospital_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  # Test suite for GET /hospitals/:hospital_id/doctors/:id
  describe 'GET /hospitals/:hospital_id/doctors/:id' do
    before { get "/hospitals/#{hospital_id}/doctors/#{id}", params: {}, headers: headers }

    context 'when hospital doctor exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the doctor' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when hospital doctor does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  # Test suite for PUT /hospitals/:hospital_id/doctors
  describe 'POST /hospitals/:hospital_id/doctors' do
    let(:valid_attributes) { { name: 'Resia', specialization: 'Kulit' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/hospitals/#{hospital_id}/doctors", params: valid_attributes, headers: headers
      end 

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/hospitals/#{hospital_id}/doctors", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /hospitals/:hospital_id/doctors/:id
  describe 'PUT /hospitals/:hospital_id/doctors/:id' do
    let(:valid_attributes) { { name: 'Tirta' }.to_json }

    before { put "/hospitals/#{hospital_id}/doctors/#{id}", params: valid_attributes, headers: headers }

    context 'when doctor exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the doctor' do
        updated_doctor = Doctor.find(id)
        expect(updated_doctor.name).to match(/Tirta/)
      end
    end

    context 'when the doctor does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  # Test suite for DELETE /hospitals/:id/doctors/:id
  describe 'DELETE /hospitals/:id/doctors/:id' do
    before { delete "/hospitals/#{hospital_id}/doctors/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end