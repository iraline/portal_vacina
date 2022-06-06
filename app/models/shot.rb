# frozen_string_literal: true

class Shot < ApplicationRecord
    validates :shot_at, presence: true

    belongs_to :person
    belongs_to :locality
    belongs_to :vaccine
    belongs_to :unity
end
