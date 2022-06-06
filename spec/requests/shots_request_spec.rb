# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shots', type: :request do
  before do
    city = City.create(name: 'City one')
    state = State.create(name: 'State one')
    locality = Locality.create(state_id: state.id, city_id: city.id)
    Vaccine.create(name: 'Vaccine test')
    Unity.create(name: 'Unity test')
    Person.create(name: 'Test', born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567891')
  end

  let!(:shot) { Shot.create(person_id: Person.first.id,
    locality_id: Locality.first.id,
    vaccine_id: Vaccine.first.id,
    unity_id: Unity.first.id,
    shot_at: '2020-07-16')
  }
  
  describe 'GET /api/v1/shots' do
    
    it 'returns a success response' do
      get '/api/v1/shots'

      expect(response).to have_http_status(:success)
    end

    it 'returns all shots' do
      get '/api/v1/shots'

      expect(JSON.parse(response.body)).to eq([{
                                                'id' => shot.id,
                                                'person_id' => shot.person_id,
                                                'locality_id' => shot.locality_id,
                                                'vaccine_id' => shot.vaccine_id,
                                                'unity_id' => shot.unity_id,
                                                'shot_at' => shot.shot_at.as_json,
                                                'created_at' => shot.created_at.as_json,
                                                'updated_at' => shot.updated_at.as_json
                                              }])
    end
  end

  describe 'GET /api/v1/shots/:id' do
    it 'returns a success response' do
      get "/api/v1/shots/#{shot.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns the choosen shot' do
      get "/api/v1/shots/#{shot.id}"

      expect(JSON.parse(response.body)).to eq({
        'id' => shot.id,
        'person_id' => shot.person_id,
        'locality_id' => shot.locality_id,
        'vaccine_id' => shot.vaccine_id,
        'unity_id' => shot.unity_id,
        'shot_at' => shot.shot_at.as_json,
        'created_at' => shot.created_at.as_json,
        'updated_at' => shot.updated_at.as_json
      })
    end
  end

  describe 'POST /api/v1/shots' do
    it 'with valid params creates a new shot' do
      expect do
        post '/api/v1/shots/', params: { shot: { person_id: Person.first.id,
            locality_id: Locality.first.id,
            vaccine_id: Vaccine.first.id,
            unity_id: Unity.first.id,
            shot_at: '2020-07-16' } }
      end.to change(Shot, :count).by(1)
    end

    it 'with valid params returns a created response' do
      post '/api/v1/shots/', params: { shot: { person_id: Person.first.id,
        locality_id: Locality.first.id,
        vaccine_id: Vaccine.first.id,
        unity_id: Unity.first.id,
        shot_at: '2020-07-16' } }

      expect(response).to have_http_status(:created)
    end

    it 'with invalid params does not create a new shot' do
      expect do
        post '/api/v1/shots/', params: { shot: { person_id: Person.first.id,
            locality_id: Locality.first.id,
            vaccine_id: Vaccine.first.id,
            unity_id: Unity.first.id,
            shot_at: '' } }
      end.to change(Locality, :count).by(0)
    end

    it 'with invalid params returns a error response' do
      post '/api/v1/shots/', params: { shot: { person_id: Person.first.id,
        locality_id: Locality.first.id,
        vaccine_id: Vaccine.first.id,
        unity_id: Unity.first.id,
        shot_at: '' } }
      
      expect(JSON.parse(response.body)).to eq({
                                                'shot_at' => ["can't be blank"]
                                              })
    end
  end
end
