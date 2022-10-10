class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :document
      t.date :birthdate
      t.integer :gender

      t.timestamps
    end
  end
end
