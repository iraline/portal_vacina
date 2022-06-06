# frozen_string_literal: true

class Locality < ApplicationRecord
  belongs_to :city
  belongs_to :state

  has_many :people
  has_many :shots
end
