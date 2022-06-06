# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'People', type: :request do
  before do
    city = City.create(name: 'City 1')
    state = State.create(name: 'State 1')

    Locality.create(state_id: state.id, city_id: city.id)
  end

  let!(:person) { Person.create(name: 'Test', born_at: '2020-07-16', locality_id: Locality.first.id, cpf: '01234567891') }

  describe 'GET /api/v1/people' do
    
    it 'returns a success response' do
      get '/api/v1/people'

      expect(response).to have_http_status(:success)
    end

    it 'returns all people' do
      get '/api/v1/people'

      expect(JSON.parse(response.body)).to eq([{
                                                'id' => person.id,
                                                'name' => person.name,
                                                'born_at' => person.born_at.as_json,
                                                'locality_id' => person.locality_id,
                                                'cpf' => person.cpf,
                                                'created_at' => person.created_at.as_json,
                                                'updated_at' => person.updated_at.as_json
                                              }])
    end
  end

  describe 'GET /api/v1/people/:id' do
    it 'returns a success response' do
      get "/api/v1/people/#{person.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns the choosen person' do
      get "/api/v1/people/#{person.id}"

      expect(JSON.parse(response.body)).to eq({
        'id' => person.id,
        'name' => person.name,
        'born_at' => person.born_at.as_json,
        'locality_id' => person.locality_id,
        'cpf' => person.cpf,
        'created_at' => person.created_at.as_json,
        'updated_at' => person.updated_at.as_json
      })
    end
  end

  describe 'POST /api/v1/people' do
    it 'with valid params creates a new person' do
      expect do
        post '/api/v1/people/', params: { person: { name: 'Test', born_at: '2020-07-16', locality_id: Locality.first.id, cpf: '01234567890' } }
      end.to change(Person, :count).by(1)
    end

    it 'with valid params returns a created response' do
      post '/api/v1/people/', params: { person: { name: 'Test', born_at: '2020-07-16', locality_id: Locality.first.id, cpf: '01234567890' } }

      expect(response).to have_http_status(:created)
    end

    it 'with invalid params does not create a new person' do
      expect do
        post '/api/v1/people/', params: { person: { name: nil, born_at: '2020-07-16', locality_id: Locality.first.id, cpf: '01234567890' } }
      end.to change(Locality, :count).by(0)
    end

    it 'with invalid params returns a error response' do
      post '/api/v1/people/', params: { person: { name: nil, born_at: '2020-07-16', locality_id: Locality.first.id, cpf: '01234567890' } }
      
      expect(JSON.parse(response.body)).to eq({
                                                'name' => ["can't be blank"]
                                              })
    end
  end

  describe 'PATCH /api/v1/people/:id' do
    let(:name) { "New name" }

    it 'with valid params updates the person' do
      patch "/api/v1/people/#{person.id}", params: { person: { name: name } }

      updated_person = Person.find_by_id(person.id)

      expect(updated_person.name).to eq(name)
    end

    it 'with valid params returns a accepted response' do
      patch "/api/v1/people/#{person.id}", params: { person: { name: name } }

      expect(response).to have_http_status(:accepted)
    end

    it 'with invalid params does not update the person' do
      patch "/api/v1/people/#{person.id}", params: { person: { name: nil } }

      updated_person = Person.find_by_id(person.id)

      expect(updated_person.name).to eq(person.name)
    end
  end
end
