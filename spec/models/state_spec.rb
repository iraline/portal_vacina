# frozen_string_literal: true

require 'rails_helper'

describe State do
  it 'valide if has a name' do
    state = State.create(name: 'State one')
    expect(state).to be_valid
  end

  it 'can not recieve a nil name' do
    state = State.create(name: nil)
    expect(state).to_not be_valid
  end

  it 'name has to be unique' do
    State.create(name: 'State one')
    state = State.create(name: 'State one')
    expect(state).to_not be_valid
  end
end
