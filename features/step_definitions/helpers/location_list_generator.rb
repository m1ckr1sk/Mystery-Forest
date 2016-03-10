class LocationListGenerator
  def self.generate_location_list(rooms_hash)
    locations = []
    rooms_hash.each do |row|
      locations << Location.new(Point.new(row["location x"].to_i,row["location y"].to_i),Room.new(row["description"],[],[]))
    end
    return locations
  end
end