# frozen_string_literal: true

require 'rails_helper'

describe Locality do
  it 'can not recieve a nil city or state' do
    locality = Locality.create(state_id: nil, city_id: nil)
    expect(locality).to_not be_valid
  end

  it 'state and city has to be unique' do
    city = City.create(name: 'City one')
    state = State.create(name: 'State one')

    Locality.create(state_id: city.id, city_id: state.id)
    locality = Locality.create(state_id: city.id, city_id: state.id)
    expect(locality).to_not be_valid
  end
end
