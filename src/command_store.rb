require_relative 'token'

class CommandStore
  def initialize
    @words = []
  end

  def store str
    str.downcase!

    synonyms = {
      "n" => "north",
      "s" => "south",
      "w" => "west",
      "e" => "east",
      "q" => "quit",
      "pick up" => "take",
      "get" => "take",
      "i" => "inventory",
      "look at" => "look",
      "examine" => "look",
      "x" => "look",
      "talk to" => "talk",

      "and" => "",
    }

    # replace synonyms with the expected word
    for k, v in synonyms do
      str.gsub!(/\b#{k}\b/, v)
    end

    @words = str.split(/\s+/)
  end

  def has_next?
    !@words.empty?
  end

  def unshift value
    @words.unshift(value)
  end

  def next_token player
    possible_types = {
      verb: %w( move take quit inventory drop look hint talk),
      direction: %w( east west south north ),
      noun: %w( )
    }

    # add directions to nouns since directions are nouns
    possible_types[:noun] += possible_types[:direction]

    # a stack to keep track of unknown words
    unknown = []
    # the token returned
    token = nil

    until token do
      # get the first word
      word = @words.shift

      # set the value to the word and the types as empty
      types = []
      value = word

      # check if a word is one of the possible types
      for type, keywords in possible_types do
        types.push(type) if keywords.include? word
      end

      # check if it is an item
      check_item = find_item(value, player)

      # if it is an item and there were unknown words before the item
      # try to see if adding the unknown words still identifies an item
      # For example if 'dagger' matches an item, and 'iron' was unkown
      # check that 'iron dagger' identifies an item
      if check_item then
        still_item = check_item
        while unknown.length > 0 && still_item do
          value = unknown.pop + " " + value
          still_item = find_item(value)
          check_item = still_item if still_item
        end

        # if an item was found, unknown is empty
        if still_item then
          types = still_item.types
          value = still_item.value
        else
          # put the first word back onto unknown
          words = value.split(/\s+/)
          unknown.push words.shift

          # put the rest of the words back
          for word in words.reverse do
            @words.unshift word
          end

          types = [:unknown]
          value = unknown.join(" ")
        end
      end

      # check if a word is referring to a person
      for person in player.current_room.people do
        if value == person.name.downcase then
          types += [:person]
          value = person
        end
      end

      # if the types are empty, the word is unknown
      # otherwise return a token with the types and value
      if types.empty? then
        unknown.push(word)

        if @words.empty? then
          token = Token.new(unknown.join(" "), [:unknwon])
        end
      else
        token = Token.new(value, types)
      end
    end

    token
  end

  def find_item name, player
    # check the current room
    for item in player.current_room.items do
      if item.id_by? name then
        return Token.new(item, [:noun, :item, :room])
      end
    end

    # check the player inventory
    for item in player.items do
      if item.id_by? name then
        return Token.new(item, [:noun, :item, :inventory])
      end
    end

    nil
  end

end
