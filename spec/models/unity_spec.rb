# frozen_string_literal: true

require 'rails_helper'

describe Unity do
  it 'valide if has a name' do
    unity = Unity.create(name: 'Unity one')
    expect(unity).to be_valid
  end

  it 'can not recieve a nil name' do
    unity = Unity.create(name: nil)
    expect(unity).to_not be_valid
  end

  it 'name has to be unique' do
    Unity.create(name: 'Unity one')
    unity = Unity.create(name: 'Unity one')
    expect(unity).to_not be_valid
  end
end
