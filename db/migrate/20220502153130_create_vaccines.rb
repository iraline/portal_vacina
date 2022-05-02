# frozen_string_literal: true

class CreateVaccines < ActiveRecord::Migration[7.0]
  def change
    create_table :vaccines do |t|
      t.string :name, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
