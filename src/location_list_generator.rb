require 'json'

class LocationListGenerator
  def self.generate_location_list(rooms_hash)
    STDOUT.puts(rooms_hash.to_json)
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
          person_script_actions = {}
          person_script_responses = {}
          if person_to_add.include?'script_actions'
            person_to_add['script_actions'].each do |script_actions|
              response = if script_actions['response'] == '' then [] else string_to_symbol_array(script_actions['response']) end
              person_script_actions[script_actions['action'].to_sym] = [script_actions['text'],response]
            end
          end
          if person_to_add.include?'script_responses'
            person_to_add['script_responses'].each do |script_responses|
              person_script_responses[script_responses['response'].to_sym] = [script_responses['text'],script_responses['next actions'].to_sym]
            end
          end
          person_script = Script.new( ScriptActions.new(person_script_actions),ScriptResponses.new(person_script_responses))
          people_for_room << Person.new(person_to_add['name'],person_to_add['description'],person_script)
        end
      end
      locations << Location.new(Point.new(row["location x"].to_i,row["location y"].to_i),Room.new(row["description"],items_for_room,people_for_room))
    end
    return locations
  end
  
  def self.string_to_symbol_array(string_to_convert)
    responses = []
    string_to_convert.gsub(/\s+/,"").split(',').each do |response_string|
      responses << response_string.to_sym
    end
    STDOUT.puts("RESPONSES #{responses}")
    return responses
  end
end