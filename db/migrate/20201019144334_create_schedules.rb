class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :schedule_day
      t.time :schedule_start
      t.time :schedule_finish
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
