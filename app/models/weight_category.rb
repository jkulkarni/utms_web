class WeightCategory < ApplicationRecord
  def range=(rstart, rend)
    self.weight_range_start = rstart
    self.weight_range_end   = rend
  end

  def range
    (weight_range_start..weight_range_end) # or as an array, or however you want to return it
  end
end
