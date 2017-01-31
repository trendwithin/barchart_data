class CreateHighLows < ActiveRecord::Migration
  def change
    create_table :high_lows, :force => true do |t|
    t.integer     :one_month_high
    t.integer     :one_month_low
    t.integer     :three_month_high
    t.integer     :three_month_low
    t.integer     :six_month_high
    t.integer     :six_month_low
    t.integer     :twelve_month_high
    t.integer     :twelve_month_low
    t.integer     :ytd_high
    t.integer     :ytd_low
    t.integer     :all_time_high
    t.integer     :all_time_low
    t.datetime    :saved_on
    t.timestamps  null: false
    end
  end
end
