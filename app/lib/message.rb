class Message
  class << self
    def start(monster)
      "#{monster.name} が現れた！"
    end
    def damage(attacker:, defender:)
      [
        "#{attacker.name} の攻撃！",
        "#{defender.name} に #{defender.damage} のダメージ！"
      ]
    end

    def victory(monster)
      [
        "#{monster.name} を倒した！",
        "#{monster.exp} の経験値を獲得！"
      ]
    end

    def defeat(brave)
      "#{brave.name} は力尽きた……"
    end

    def level_up(brave)
      "#{brave.name} のレベルが #{brave.level} に上がった！"
    end
  end
end