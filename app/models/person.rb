# frozen_string_literal: true

class Person < ApplicationRecord
  validates :cpf, uniqueness: true, presence: true, numericality: { only_integer: true }, length: { is: 11 }

  validates :name, :born_at, presence: true

  has_many :shots
  belongs_to :locality
end
