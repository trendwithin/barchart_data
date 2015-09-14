class NewLow < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
  validates :symbol, uniqueness: { scope: :saved_on }
end
