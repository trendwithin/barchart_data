class AllTimeHigh < ActiveRecord::Base
  validates :symbol, :saved_on, presence: true
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
end
