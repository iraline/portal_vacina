# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'States', type: :request do
  context('With states in database') do
    before do
      post '/api/v1/states/', params: { name: 'Test_1' }
      post '/api/v1/states/', params: { name: 'Test_2' }
    end

    describe 'GET /api/v1/states' do
      it 'returns all the states' do
        get '/api/v1/states/'

        state1 = State.first
        state2 = State.second

        expect(JSON.parse(response.body).size).to eq(2)
        expect(JSON.parse(response.body)[0]).to eq({
                                                     'id' => state1.id,
                                                     'name' => state1.name,
                                                     'created_at' => state1.created_at.as_json,
                                                     'updated_at' => state1.updated_at.as_json
                                                   })
        expect(JSON.parse(response.body)[1]).to eq({
                                                     'id' => state2.id,
                                                     'name' => state2.name,
                                                     'created_at' => state2.created_at.as_json,
                                                     'updated_at' => state2.updated_at.as_json
                                                   })
        expect(response.body).to include('Test_1')
        expect(response.body).to include('Test_2')
      end

      it 'return a sucess response' do
        get '/api/v1/states/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /api/v1/states/:id' do
      let(:state1) { State.first }

      it 'returns only the selected state' do
        get "/api/v1/states/#{state1.id}"

        expect(JSON.parse(response.body)).to eq({
                                                  'id' => state1.id,
                                                  'name' => state1.name,
                                                  'created_at' => state1.created_at.as_json,
                                                  'updated_at' => state1.updated_at.as_json
                                                })
      end

      it 'return a sucess response' do
        get "/api/v1/states/#{state1.id}"
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /api/v1/states' do
      it 'with valid params creates a new state' do
        expect do
          post '/api/v1/states/', params: { name: 'IraLand' }
        end.to change(State, :count).by(1)
      end

      it 'with valid params returns a created response' do
        post '/api/v1/states/', params: { name: 'IraLand' }
        expect(response).to have_http_status(:created)
      end

      it 'can not create a state with a empty name' do
        post '/api/v1/states/', params: { name: nil }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not create a state with a a name that already exists' do
        post '/api/v1/states/', params: { name: 'Test_1' }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end

    describe 'PATCH /api/v1/states/:id' do
      let(:state1) { State.first }

      it 'with valid params updates a state' do
        patch "/api/v1/states/#{state1.id}", params: { state: { name: 'IraLand' } }

        state = State.find_by_id(state1.id)
        expect(state.name).to eq('IraLand')
      end

      it 'with valid params returns a accepted response' do
        patch "/api/v1/states/#{state1.id}", params: { state: { name: 'IraLand' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'can not update a state with a empty name' do
        patch "/api/v1/states/#{state1.id}", params: { state: { name: nil } }

        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not update a state with a a name that already exists' do
        patch "/api/v1/states/#{state1.id}", params: { state: { name: 'Test_2' } }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end
  end
end
