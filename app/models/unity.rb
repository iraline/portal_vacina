# frozen_string_literal: true

class Unity < ApplicationRecord
    validates :name, uniqueness: true, presence: true

    has_many :shots
end
