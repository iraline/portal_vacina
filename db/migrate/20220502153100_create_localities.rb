# frozen_string_literal: true

class CreateLocalities < ActiveRecord::Migration[7.0]
  def change
    create_table :localities do |t|
      t.references :state, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.index  [:state_id, :city_id], unique: true
      
      t.timestamps
    end
  end
end
