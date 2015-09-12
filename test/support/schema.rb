ActiveRecord::Schema.define do
  self.verbose = false

  create_table :all_time_highs, :force => true do |t|
    t.string     :symbol
    t.datetime   :saved_on
    t.timestamps null: false
  end

  create_table :new_highs, :force => true do |t|
    t.string     :symbol
    t.datetime   :saved_on
    t.timestamps null: false
  end

  create_table :new_lows, :force => true do |t|
    t.string     :symbol
    t.datetime   :saved_on
    t.timestamps null: false
  end

  create_table :all_time_lows, :force => true do |t|
    t.string     :symbol
    t.datetime   :saved_on
    t.timestamps null: false
  end

    create_table :high_lows, :force => true do |t|
    t.string     :one_month_high
    t.string     :one_month_low
    t.string     :three_month_high
    t.string     :three_month_low
    t.string     :six_month_high
    t.string     :six_month_low
    t.string     :twelve_month_high
    t.string     :twelve_month_low
    t.string     :ytd_high
    t.string     :ytd_low
    t.datetime   :saved_on
    t.timestamps null: false
  end
end
