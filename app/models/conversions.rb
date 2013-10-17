module Conversions
  def in_feet(meters)
    (meters * 3.28084).round
  end

  def in_miles(km)
    (km * 0.621371).round(1)
  end

  def in_km(miles)
    (miles * 1.60934).round(1)
  end
end
