# 計算処理モジュール
# modelでincludeでmixin（取り込む）する。
module Calculation
  Damage_Percentage_Range = 30..60
  Skill_Damage_Percentage_Range = 10..100
  Spell_1_Damage_Percentage_Range = 40..70
  Spell_2_Damage_Percentage_Range = 50..90
  Brave_Status_Up_Percentage_Range = 40..60
  Brave_Status_Up_Bonus_Range = 0..2

  def damage_calc(attacker:,defender:)
    offense = attacker.offense
    defense = defender.defense

    if defender.name == "シュウ"
      damage = 1
    else
      # 割合にしたいので100で割る。ランダム値が50なら 0.5=50% になる
      random_rate = rand(Damage_Percentage_Range) / 100.0
      # atk:10,def:4,random_rate:0.5なら(10-4/2)*0.5=4のダメージ
      damage = (offense - defense / 2) * random_rate
      # maxメソッド：[,]内の中から一番大きい数字を返す。
      # damageが１より小さくなっても１はの方が取り出されるので最小ダメージが１となる。
      [damage.to_i, 1].max
    end
  end

  def skill_damage_calc(attacker: self,defender: monster)
    offense = attacker.offense
    defense = defender.defense

    if defender.name == "トップライフコーチ"
      damage = 777
    else
      random_rate = rand(Skill_Damage_Percentage_Range) / 100.0
      damage = (offense - defense / 2) * random_rate
      [damage.to_i, 1].max
    end
  end

  def spell_1_damage_calc(attacker: self,defender: monster)
    offense = attacker.offense
    defense = defender.defense

    random_rate = rand(Spell_1_Damage_Percentage_Range) / 100.0
    damage = (offense - defense / 2) * random_rate
    [damage.to_i, 1].max
  end

  def spell_2_damage_calc(attacker: self,defender: monster)
    offense = attacker.offense
    defense = defender.defense

    random_rate = rand(Spell_2_Damage_Percentage_Range) / 100.0
    damage = (offense - defense / 2) * random_rate
    [damage.to_i, 1].max
  end


  def monster_spell_damage_calc(attacker: self,defender: monster)
    if defender.name == "勇者"
      damage = 0
    else
      damage = 3
    end
  end

  


  # model/braveのレベルアップ量で使う
  def brave_status_up(level)
    bonus_add = rand(Brave_Status_Up_Bonus_Range)
    level_up_percentage = rand(Brave_Status_Up_Percentage_Range)
    bonus_add + (level * level_up_percentage / 100.0).ceil
  end


end
