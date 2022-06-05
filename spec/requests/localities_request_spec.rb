# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Localities', type: :request do
  before do
    city = City.create(name: 'City 1')
    state = State.create(name: 'State 1')

    # let(:locality) { Locality.create(state_id: state.id , city_id: city.id) }
    Locality.create(state_id: state.id, city_id: city.id)
  end

  describe 'GET /api/v1/localities' do
    let(:locality) { Locality.first }

    it 'returns a success response' do
      get '/api/v1/localities'

      expect(response).to have_http_status(:success)
    end

    it 'returns all localities' do
      get '/api/v1/localities'

      expect(JSON.parse(response.body)).to eq([{
                                                'id' => locality.id,
                                                'state_id' => locality.state_id,
                                                'city_id' => locality.city_id,
                                                'created_at' => locality.created_at.as_json,
                                                'updated_at' => locality.updated_at.as_json
                                              }])
    end
  end

  describe 'GET /api/v1/localities/:id' do
    let(:locality) { Locality.first }

    it 'returns a success response' do
      get "/api/v1/localities/#{locality.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns the choosen locality' do
      get "/api/v1/localities/#{locality.id}"

      expect(JSON.parse(response.body)).to eq({
                                                'id' => locality.id,
                                                'state_id' => locality.state_id,
                                                'city_id' => locality.city_id,
                                                'created_at' => locality.created_at.as_json,
                                                'updated_at' => locality.updated_at.as_json
                                              })
    end
  end

  describe 'POST /api/v1/localities' do
    let(:locality) { Locality.first }
    let(:city) { City.create(name: 'City 2') }
    let(:state) { State.create(name: 'State 2') }

    it 'with valid params creates a new locality' do
      expect do
        post '/api/v1/localities/', params: { state_id: state.id, city_id: city.id }
      end.to change(Locality, :count).by(1)
    end

    it 'with valid params returns a created response' do
      post '/api/v1/localities/', params: { state_id: state.id, city_id: city.id }

      expect(response).to have_http_status(:created)
    end

    it 'with invalid params does not create a new locality' do
      expect do
        post '/api/v1/localities/', params: { state_id: nil, city_id: nil }
      end.to change(Locality, :count).by(0)
    end

    it 'with invalid params returns a error response' do
      post '/api/v1/localities/', params: { state_id: nil, city_id: nil }

      expect(JSON.parse(response.body)).to eq({
                                                'city' => ['must exist'],
                                                'state' => ['must exist']
                                              })
    end
  end

  describe 'PATCH /api/v1/localities/:id' do
    let(:locality) { Locality.first }
    let(:city) { City.create(name: 'City 3') }

    it 'with valid params updates the locality' do
      patch "/api/v1/localities/#{locality.id}", params: { locality: { city_id: city.id } }

      updated_locality = Locality.find_by_id(locality.id)

      expect(updated_locality.city.name).to eq(city.name)
    end

    it 'with valid params returns a XXXXXX response' do
      patch "/api/v1/localities/#{locality.id}", params: { locality: { city_id: city.id } }

      expect(response).to have_http_status(:accepted)
    end

    it 'with invalid params does not update the locality' do
      patch "/api/v1/localities/#{locality.id}", params: { locality: { city_id: nil } }

      updated_locality = Locality.find_by_id(locality.id)

      expect(updated_locality.city.name).to eq(locality.city.name)
    end

    it 'with invalid params returns a XXXXX response' do
      patch "/api/v1/localities/#{locality.id}", params: { locality: { city_id: nil } }

      expect(response).to have_http_status(:success)
    end
  end
end
