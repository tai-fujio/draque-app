class Message
  class << self
    def start(monster)
      # "#{monster.name} appearded"
      "#{monster.name} が現れた!!"
      
    end

    def damage(attacker:, defender:)
      # [
      #   "#{attacker.name} attack!!",
      #   "#{defender.name} received #{defender.damage} damage!!"
      # ]
      [
        "#{attacker.name} のターン!!",
        "#{defender.name} は #{defender.damage} ダメージを受けた!!"
      ]
    end

    def victory(monster)
      # [
      #   "Defeated #{monster.name}!!",
      #   "Awarded #{monster.exp} points!!"
      # ]
      [
        " #{monster.name}を倒した!!",
        "経験値を #{monster.exp} 獲得した!!"
      ]
    end

    def lose(brave)
      # "#{brave.name} was exhausted"
      "#{brave.name} は力尽きた..."
    end

    def level_up(brave)
      # "#{brave.name} went up level #{brave.level}!!"
      "#{brave.name} は #{brave.level}レベルに上がった!!"
    end

    def exit
      # ["success escape"]
      ["うまく逃げ切れた"]
    end

  end
end
