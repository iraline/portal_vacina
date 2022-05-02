# frozen_string_literal: true

class CreateUnities < ActiveRecord::Migration[7.0]
  def change
    create_table :unities do |t|
      t.string :name, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
