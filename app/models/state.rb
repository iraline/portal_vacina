# frozen_string_literal: true

class State < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :localities
end
