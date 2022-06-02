# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :localities
end
