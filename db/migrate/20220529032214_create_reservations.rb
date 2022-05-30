class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.integer :number_of_items, null: false
      t.date :reservation_day, null: false
      t.integer :reservation_time, null: false
      t.integer :reservation_status, default: 0, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
