ActiveRecord::Schema.define do
  self.verbose = false

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
end




# ActiveRecord::Schema.define do
#   self.verbose = false
#
#   create_table :all_time_highs, :force => true do |t|
#     t.string     :symbol
#     t.datetime   :saved_on
#     t.timestamps null: false
#   end
#
#   create_table :new_highs, :force => true do |t|
#     t.string     :symbol
#     t.datetime   :saved_on
#     t.timestamps null: false
#   end
#
#   create_table :new_lows, :force => true do |t|
#     t.string     :symbol
#     t.datetime   :saved_on
#     t.timestamps null: false
#   end
#
#   create_table :all_time_lows, :force => true do |t|
#     t.string     :symbol
#     t.datetime   :saved_on
#     t.timestamps null: false
#   end
#
#     create_table :high_lows, :force => true do |t|
#     t.integer     :one_month_high
#     t.integer     :one_month_low
#     t.integer     :three_month_high
#     t.integer     :three_month_low
#     t.integer     :six_month_high
#     t.integer     :six_month_low
#     t.integer     :twelve_month_high
#     t.integer     :twelve_month_low
#     t.integer     :ytd_high
#     t.integer     :ytd_low
#     t.datetime   :saved_on
#     t.timestamps null: false
#   end
# end
