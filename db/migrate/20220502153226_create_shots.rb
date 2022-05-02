# frozen_string_literal: true

class CreateShots < ActiveRecord::Migration[7.0]
  def change
    create_table :shots do |t|
      t.references :person, null: false, foreign_key: true
      t.references :locality, null: false, foreign_key: true
      t.references :vaccine, null: false, foreign_key: true
      t.references :unity, null: false, foreign_key: true
      t.date :shot_at

      t.timestamps
    end
  end
end
