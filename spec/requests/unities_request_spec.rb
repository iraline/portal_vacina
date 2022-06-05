# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Unitys', type: :request do
  context('With unities in database') do
    before do
      post '/api/v1/unities/', params: { name: 'Test_1' }
      post '/api/v1/unities/', params: { name: 'Test_2' }
    end

    describe 'GET /api/v1/unities' do
      it 'returns all the unities' do
        get '/api/v1/unities/'

        unity1 = Unity.first
        unity2 = Unity.second

        expect(JSON.parse(response.body).size).to eq(2)
        expect(JSON.parse(response.body)[0]).to eq({
                                                     'id' => unity1.id,
                                                     'name' => unity1.name,
                                                     'created_at' => unity1.created_at.as_json,
                                                     'updated_at' => unity1.updated_at.as_json
                                                   })
        expect(JSON.parse(response.body)[1]).to eq({
                                                     'id' => unity2.id,
                                                     'name' => unity2.name,
                                                     'created_at' => unity2.created_at.as_json,
                                                     'updated_at' => unity2.updated_at.as_json
                                                   })
        expect(response.body).to include('Test_1')
        expect(response.body).to include('Test_2')
      end

      it 'return a sucess response' do
        get '/api/v1/unities/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /api/v1/unities/:id' do
      let(:unity1) { Unity.first }

      it 'returns only the selected unity' do
        get "/api/v1/unities/#{unity1.id}"

        expect(JSON.parse(response.body)).to eq({
                                                  'id' => unity1.id,
                                                  'name' => unity1.name,
                                                  'created_at' => unity1.created_at.as_json,
                                                  'updated_at' => unity1.updated_at.as_json
                                                })
      end

      it 'return a sucess response' do
        get "/api/v1/unities/#{unity1.id}"
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /api/v1/unities' do
      it 'with valid params creates a new unity' do
        expect do
          post '/api/v1/unities/', params: { name: 'IraLand' }
        end.to change(Unity, :count).by(1)
      end

      it 'with valid params returns a created response' do
        post '/api/v1/unities/', params: { name: 'IraLand' }
        expect(response).to have_http_status(:created)
      end

      it 'can not create a unity with a empty name' do
        post '/api/v1/unities/', params: { name: nil }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not create a unity with a a name that already exists' do
        post '/api/v1/unities/', params: { name: 'Test_1' }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end

    describe 'PATCH /api/v1/unities/:id' do
      let(:unity1) { Unity.first }

      it 'with valid params updates a unity' do
        patch "/api/v1/unities/#{unity1.id}", params: { unity: { name: 'IraLand' } }

        unity = Unity.find_by_id(unity1.id)
        expect(unity.name).to eq('IraLand')
      end

      it 'with valid params returns a created response' do
        patch "/api/v1/unities/#{unity1.id}", params: { unity: { name: 'IraLand' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'can not update a unity with a empty name' do
        patch "/api/v1/unities/#{unity1.id}", params: { unity: { name: nil } }

        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not update a unity with a a name that already exists' do
        patch "/api/v1/unities/#{unity1.id}", params: { unity: { name: 'Test_2' } }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end
  end
end
