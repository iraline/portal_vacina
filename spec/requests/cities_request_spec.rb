# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cities', type: :request do
  context('With cities in database') do
    before do
      post '/api/v1/cities/', params: { name: 'Test_1' }
      post '/api/v1/cities/', params: { name: 'Test_2' }
    end

    describe 'GET /api/v1/cities' do
      it 'returns all the cities' do
        get '/api/v1/cities/'

        city1 = City.first
        city2 = City.second

        expect(JSON.parse(response.body).size).to eq(2)
        expect(JSON.parse(response.body)[0]).to eq({
                                                     'id' => city1.id,
                                                     'name' => city1.name,
                                                     'created_at' => city1.created_at.as_json,
                                                     'updated_at' => city1.updated_at.as_json
                                                   })
        expect(JSON.parse(response.body)[1]).to eq({
                                                     'id' => city2.id,
                                                     'name' => city2.name,
                                                     'created_at' => city2.created_at.as_json,
                                                     'updated_at' => city2.updated_at.as_json
                                                   })
        expect(response.body).to include('Test_1')
        expect(response.body).to include('Test_2')
      end

      it 'return a sucess response' do
        get '/api/v1/cities/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /api/v1/cities/:id' do
      let(:city1) { City.first }

      it 'returns only the selected city' do
        get "/api/v1/cities/#{city1.id}"

        expect(JSON.parse(response.body)).to eq({
                                                  'id' => city1.id,
                                                  'name' => city1.name,
                                                  'created_at' => city1.created_at.as_json,
                                                  'updated_at' => city1.updated_at.as_json
                                                })
      end

      it 'return a sucess response' do
        get "/api/v1/cities/#{city1.id}"
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /api/v1/cities' do
      it 'with valid params creates a new city' do
        expect do
          post '/api/v1/cities/', params: { name: 'IraLand' }
        end.to change(City, :count).by(1)
      end

      it 'with valid params returns a created response' do
        post '/api/v1/cities/', params: { name: 'IraLand' }
        expect(response).to have_http_status(:created)
      end

      it 'can not create a city with a empty name' do
        post '/api/v1/cities/', params: { name: nil }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not create a city with a a name that already exists' do
        post '/api/v1/cities/', params: { name: 'Test_1' }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end

    describe 'PATCH /api/v1/cities/:id' do
      let(:city1) { City.first }

      it 'with valid params updates a city' do
        patch "/api/v1/cities/#{city1.id}", params: { city: { name: 'IraLand' } }

        city = City.find_by_id(city1.id)
        expect(city.name).to eq('IraLand')
      end

      it 'with valid params returns a created response' do
        patch "/api/v1/cities/#{city1.id}", params: { city: { name: 'IraLand' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'can not update a city with a empty name' do
        patch "/api/v1/cities/#{city1.id}", params: { city: { name: nil } }

        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not update a city with a a name that already exists' do
        patch "/api/v1/cities/#{city1.id}", params: { city: { name: 'Test_2' } }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end
  end
end
