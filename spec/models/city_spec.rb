# frozen_string_literal: true

require 'rails_helper'

describe City do
  it 'valide if has a name' do
    city = City.create(name: 'City one')
    expect(city).to be_valid
  end

  it 'can not recieve a nil name' do
    city = City.create(name: nil)
    expect(city).to_not be_valid
  end

  it 'name has to be unique' do
    City.create(name: 'City one')
    city = City.create(name: 'City one')
    expect(city).to_not be_valid
  end
end
