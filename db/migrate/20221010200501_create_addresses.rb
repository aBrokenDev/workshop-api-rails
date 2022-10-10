class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.string :postal_code
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :street
      t.integer :number
      t.string :complement

      t.timestamps
    end
  end
end
