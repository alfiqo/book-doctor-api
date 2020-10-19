require "rails_helper"

RSpec.describe "Hospitals API", type: :request do
  let(:user) { create(:user) }
  let!(:hospitals) { create_list(:hospital, 10) }
  let(:hospital_id) { hospitals.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /hospitals
  describe "GET /hospitals" do
    before { get "/hospitals", params: {}, headers: headers }

    it "returns hospital" do
      # `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /hospitals/:id
  describe "GET /hospitals/:id" do
    before { get "/hospitals/#{hospital_id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns the todo" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(hospital_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:hospital_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/data not found/)
      end
    end
  end

  # Test suite for POST /hospitals
  describe "POST /hospitals" do
    # payload
    # let(:valid_attributes) { { name: "RS Persahabatan", address: "Jl. Persahabatan Raya No.1 Jakarta Timur 13230" } }
    let(:valid_attributes) do
      { name: "RS Persahabatan", address: "Jl. Persahabatan Raya No.1 Jakarta Timur 13230" }.to_json
    end 

    context "when the request is valid" do
      # before { post "/hospitals", params: valid_attributes }
      before { post '/hospitals', params: valid_attributes, headers: headers }

      it "creates a hospital" do
        expect(json["name"]).to eq("RS Persahabatan")
        expect(json["address"]).to eq("Jl. Persahabatan Raya No.1 Jakarta Timur 13230")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      # before { post "/hospitals", params: { name: "Foobar" } }
      let(:invalid_attributes) { { name: "Foobar" }.to_json }
      before { post '/hospitals', params: invalid_attributes, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        # expect(response.body).to match(/Validation failed: Address can't be blank/)
        expect(json['message'])
          .to match(/Validation failed: Address can't be blank/)
      end
    end
  end

  # Test suite for PUT /hospitals/:id
  describe "PUT /hospitals/:id" do
    let(:valid_attributes) { { name: "RS Pertamina" }.to_json }

    context "when the record exists" do
      before { put "/hospitals/#{hospital_id}", params: valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /hospitals/:id
  describe "DELETE /hospitals/:id" do
    before { delete "/hospitals/#{hospital_id}", params: {}, headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
