class HighLow < ActiveRecord::Base
  validates :saved_on, presence: true, uniqueness: true
  validates :one_month_high, :one_month_low, :three_month_high, :three_month_low,
            :six_month_high, :six_month_low, :twelve_month_high, :twelve_month_low,
            :ytd_high, :ytd_low, presence: true
end
