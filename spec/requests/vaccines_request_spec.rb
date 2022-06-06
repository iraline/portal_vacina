# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vaccines', type: :request do
  context('With vaccines in database') do
    before do
      post '/api/v1/vaccines/', params: { name: 'Test_1' }
      post '/api/v1/vaccines/', params: { name: 'Test_2' }
    end

    describe 'GET /api/v1/vaccines' do
      it 'returns all the vaccines' do
        get '/api/v1/vaccines/'

        vaccine1 = Vaccine.first
        vaccine2 = Vaccine.second

        expect(JSON.parse(response.body).size).to eq(2)
        expect(JSON.parse(response.body)[0]).to eq({
                                                     'id' => vaccine1.id,
                                                     'name' => vaccine1.name,
                                                     'created_at' => vaccine1.created_at.as_json,
                                                     'updated_at' => vaccine1.updated_at.as_json
                                                   })
        expect(JSON.parse(response.body)[1]).to eq({
                                                     'id' => vaccine2.id,
                                                     'name' => vaccine2.name,
                                                     'created_at' => vaccine2.created_at.as_json,
                                                     'updated_at' => vaccine2.updated_at.as_json
                                                   })
        expect(response.body).to include('Test_1')
        expect(response.body).to include('Test_2')
      end

      it 'return a sucess response' do
        get '/api/v1/vaccines/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /api/v1/vaccines/:id' do
      let(:vaccine1) { Vaccine.first }

      it 'returns only the selected vaccine' do
        get "/api/v1/vaccines/#{vaccine1.id}"

        expect(JSON.parse(response.body)).to eq({
                                                  'id' => vaccine1.id,
                                                  'name' => vaccine1.name,
                                                  'created_at' => vaccine1.created_at.as_json,
                                                  'updated_at' => vaccine1.updated_at.as_json
                                                })
      end

      it 'return a sucess response' do
        get "/api/v1/vaccines/#{vaccine1.id}"
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /api/v1/vaccines' do
      it 'with valid params creates a new vaccine' do
        expect do
          post '/api/v1/vaccines/', params: { name: 'IraLand' }
        end.to change(Vaccine, :count).by(1)
      end

      it 'with valid params returns a created response' do
        post '/api/v1/vaccines/', params: { name: 'IraLand' }
        expect(response).to have_http_status(:created)
      end

      it 'can not create a vaccine with a empty name' do
        post '/api/v1/vaccines/', params: { name: nil }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not create a vaccine with a a name that already exists' do
        post '/api/v1/vaccines/', params: { name: 'Test_1' }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end

    describe 'PATCH /api/v1/vaccines/:id' do
      let(:vaccine1) { Vaccine.first }

      it 'with valid params updates a vaccine' do
        patch "/api/v1/vaccines/#{vaccine1.id}", params: { vaccine: { name: 'IraLand' } }

        vaccine = Vaccine.find_by_id(vaccine1.id)
        expect(vaccine.name).to eq('IraLand')
      end

      it 'with valid params returns a accepted response' do
        patch "/api/v1/vaccines/#{vaccine1.id}", params: { vaccine: { name: 'IraLand' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'can not update a vaccine with a empty name' do
        patch "/api/v1/vaccines/#{vaccine1.id}", params: { vaccine: { name: nil } }

        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not update a vaccine with a a name that already exists' do
        patch "/api/v1/vaccines/#{vaccine1.id}", params: { vaccine: { name: 'Test_2' } }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end
  end
end
