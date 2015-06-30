ActiveRecord::Schema.define do
  self.verbose = false

  create_table :all_time_highs, :force => true do |t|
    t.string     :symbol
    t.datetime   :saved_on
    t.timestamps null: false
  end
end
