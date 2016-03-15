class LocationListGenerator
  def self.generate_location_list(rooms_hash)
    locations = []
    rooms_hash.each do |row|
      items_for_room = []
      if !row['items'].nil?
        row['items'].each do |item_to_add|
          items_for_room << Item.new(item_to_add['name'],item_to_add['possibles'].split(','),item_to_add['description'])
        end
      end
      people_for_room = []
      if !row['people'].nil?
        row['people'].each do |person_to_add|
          person_to_add['script_actions'].each do |script_actions|
            STDOUT.puts("ADDING ACTIONS")
          end
          people_for_room << Person.new(person_to_add['name'],person_to_add['description'],nil)
        end
      end
      locations << Location.new(Point.new(row["location x"].to_i,row["location y"].to_i),Room.new(row["description"],items_for_room,people_for_room))
    end
    return locations
  end
end