class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|

      t.date :date, null: false
      t.integer :start_time, null: false
      t.integer :end_time, null: false

      t.boolean :confirmed, default: false
      t.string :phone_number, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
