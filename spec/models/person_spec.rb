# frozen_string_literal: true

require 'rails_helper'

describe Person do
  before do
    city = City.create(name: 'City 1')
    state = State.create(name: 'State 1')

    Locality.create(state_id: state.id, city_id: city.id)
  end

  let(:locality) { Locality.first }

  describe 'Person is not valid when' do
    it 'recieves an empty name' do
      person = Person.create(name: nil, born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567891')
      expect(person).to_not be_valid
    end

    it 'recieves an empty born_at' do
      person = Person.create(name: 'Test', born_at: nil, locality_id: locality.id, cpf: '01234567891')
      expect(person).to_not be_valid
    end

    it 'recieves an empty cpf' do
      person = Person.create(name: 'Test', born_at: '2020-07-16', locality_id: locality.id, cpf: nil)
      expect(person).to_not be_valid
    end
  end

  describe 'Person is valid when' do
    it 'receives a cpf with exactly 11 digits' do
      person = Person.create(name: 'Test', born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567812')
      expect(person).to be_valid
    end

    it 'cpf is unique' do
      Person.create(name: nil, born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567891')
      person = Person.create(name: nil, born_at: '2020-07-16', locality_id: locality.id, cpf: '01234567891')
      expect(person).to_not be_valid
    end
  end
end
