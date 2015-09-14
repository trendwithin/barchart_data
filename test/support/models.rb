class AllTimeHigh < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
  validates :symbol, uniqueness: { scope: :saved_on }
end

class NewHigh < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
  validates :symbol, uniqueness: { scope: :saved_on }
end

class NewLow < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
  validates :symbol, uniqueness: { scope: :saved_on }
end

class AllTimeLow < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
  validates :symbol, uniqueness: { scope: :saved_on }
end

class HighLow < ActiveRecord::Base
  validates :saved_on, presence: true, uniqueness: true
  validates :one_month_high, :one_month_low, :three_month_high, :three_month_low,
            :six_month_high, :six_month_low, :twelve_month_high, :twelve_month_low,
            :ytd_high, :ytd_low, presence: true
end
