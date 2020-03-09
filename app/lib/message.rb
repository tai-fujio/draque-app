class Message
  class << self
    def start(monster)
      "#{monster.name} appearded"
      
    end

    def damage(attacker:, defender:)
      [
        "#{attacker.name} attack!!",
        "#{defender.name} received #{defender.damage} damage!!"
      ]
    end

    def victory(monster)
      [
        "Defeated #{monster.name}!!",
        "Awarded #{monster.exp} points!!"
      ]
    end

    def lose(brave)
      "#{brave.name} was exhausted"
    end

    def level_up(brave)
      "#{brave.name} went up level #{brave.level}!!"
    end

    def exit
      "success escape"
    end

  end
end