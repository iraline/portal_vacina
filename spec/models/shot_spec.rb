# frozen_string_literal: true

require 'rails_helper'

describe Shot do

  before do
    city = City.create(name: 'City one')
    state = State.create(name: 'State one')
    locality = Locality.create(state_id: state.id, city_id: city.id)
    Vaccine.create(name: 'Vaccine test')
    Unity.create(name: 'Unity test')
    Person.create(name: 'Test', born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567891')
  end

  it 'field shot_at can not be empty' do
    shot = Shot.create(person_id: Person.first.id,
      locality_id: Locality.first.id,
      vaccine_id: Vaccine.first.id,
      unity_id: Unity.first.id,
      shot_at: '')
    expect(shot).to_not be_valid
  end
end
