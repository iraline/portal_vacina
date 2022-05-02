# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.date :born_at, null: false
      t.references :locality, null: false, foreign_key: true
      t.string :cpf, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
