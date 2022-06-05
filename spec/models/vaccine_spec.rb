# frozen_string_literal: true

require 'rails_helper'

describe Vaccine do
  it 'valide if has a name' do
    vaccine = Vaccine.create(name: 'Vaccine one')
    expect(vaccine).to be_valid
  end

  it 'can not recieve a nil name' do
    vaccine = Vaccine.create(name: nil)
    expect(vaccine).to_not be_valid
  end

  it 'name has to be unique' do
    Vaccine.create(name: 'Vaccine one')
    vaccine = Vaccine.create(name: 'Vaccine one')
    expect(vaccine).to_not be_valid
  end
end
