class CreateAllTimeLows < ActiveRecord::Migration
  def change
    create_table :all_time_lows, :force => true do |t|
      t.string :symbol
      t.datetime :saved_on
      t.timestamps null: false
    end
  end
end
