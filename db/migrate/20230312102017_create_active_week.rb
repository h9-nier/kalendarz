class CreateActiveWeek < ActiveRecord::Migration[7.0]
  def change
    create_table :active_weeks do |t|
      
      t.date :first_day
      # w modelu ustawione na początek bieżącego tygodnia

      t.boolean :monday, default: false
      t.boolean :tuesday, default: false
      t.boolean :wednesday, default: false
      t.boolean :thursday, default: false
      t.boolean :friday, default: false
      t.boolean :saturday, default: false
      t.boolean :sunday, default: false

      t.integer :step, default: 60

      t.integer :start_time, default: 480
      t.integer :end_time, default: 960

    end
  end
end
