# frozen_string_literal: true

require 'rails_helper'

describe Role do
  it 'valide if has a name' do
    role = Role.create(name: 'Role one')
    expect(role).to be_valid
  end

  it 'can not recieve a nil name' do
    role = Role.create(name: nil)
    expect(role).to_not be_valid
  end

  it 'name has to be unique' do
    Role.create(name: 'Role one')
    role = Role.create(name: 'Role one')
    expect(role).to_not be_valid
  end
end
