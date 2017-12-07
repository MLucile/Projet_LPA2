class Town < ActiveRecord::Base
  
  before_validation :load_position
  validates :lat, :lon, presence: true
  
  def get_weather()
    result = ForecastIO.forecast(self.lat, self.lon)
  end
  
  private
  def load_position
    places = Nominatim.search(name).limit(1).first
    if places
      self.lat = places.lat
      self.lon = places.lon
    end
  end
end
