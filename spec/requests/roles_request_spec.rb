# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles', type: :request do
  context('With roles in database') do
    before do
      post '/api/v1/roles/', params: { name: 'Test_1' }
      post '/api/v1/roles/', params: { name: 'Test_2' }
    end

    describe 'GET /api/v1/roles' do
      it 'returns all the roles' do
        get '/api/v1/roles/'

        role1 = Role.first
        role2 = Role.second

        expect(JSON.parse(response.body).size).to eq(2)
        expect(JSON.parse(response.body)[0]).to eq({
                                                     'id' => role1.id,
                                                     'name' => role1.name,
                                                     'created_at' => role1.created_at.as_json,
                                                     'updated_at' => role1.updated_at.as_json
                                                   })
        expect(JSON.parse(response.body)[1]).to eq({
                                                     'id' => role2.id,
                                                     'name' => role2.name,
                                                     'created_at' => role2.created_at.as_json,
                                                     'updated_at' => role2.updated_at.as_json
                                                   })
        expect(response.body).to include('Test_1')
        expect(response.body).to include('Test_2')
      end

      it 'return a sucess response' do
        get '/api/v1/roles/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /api/v1/roles/:id' do
      let(:role1) { Role.first }

      it 'returns only the selected role' do
        get "/api/v1/roles/#{role1.id}"

        expect(JSON.parse(response.body)).to eq({
                                                  'id' => role1.id,
                                                  'name' => role1.name,
                                                  'created_at' => role1.created_at.as_json,
                                                  'updated_at' => role1.updated_at.as_json
                                                })
      end

      it 'return a sucess response' do
        get "/api/v1/roles/#{role1.id}"
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /api/v1/roles' do
      it 'with valid params creates a new role' do
        expect do
          post '/api/v1/roles/', params: { name: 'IraLand' }
        end.to change(Role, :count).by(1)
      end

      it 'with valid params returns a created response' do
        post '/api/v1/roles/', params: { name: 'IraLand' }
        expect(response).to have_http_status(:created)
      end

      it 'can not create a role with a empty name' do
        post '/api/v1/roles/', params: { name: nil }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not create a role with a a name that already exists' do
        post '/api/v1/roles/', params: { name: 'Test_1' }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end

    describe 'PATCH /api/v1/roles/:id' do
      let(:role1) { Role.first }

      it 'with valid params updates a role' do
        patch "/api/v1/roles/#{role1.id}", params: { role: { name: 'IraLand' } }

        role = Role.find_by_id(role1.id)
        expect(role.name).to eq('IraLand')
      end

      it 'with valid params returns a accepted response' do
        patch "/api/v1/roles/#{role1.id}", params: { role: { name: 'IraLand' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'can not update a role with a empty name' do
        patch "/api/v1/roles/#{role1.id}", params: { role: { name: nil } }

        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"]
                                                })
      end

      it 'can not update a role with a a name that already exists' do
        patch "/api/v1/roles/#{role1.id}", params: { role: { name: 'Test_2' } }
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ['has already been taken']
                                                })
      end
    end
  end
end
