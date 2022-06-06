# frozen_string_literal: true

require 'rails_helper'

describe Locality do
  it 'can not recieve a nil city or state' do
    locality = Locality.create(state_id: nil, city_id: nil)
    expect(locality).to_not be_valid
  end
end
