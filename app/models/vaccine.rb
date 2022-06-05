# frozen_string_literal: true

class Vaccine < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :shots
end
