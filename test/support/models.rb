class AllTimeHigh < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
end

class NewHigh < ActiveRecord::Base
end
