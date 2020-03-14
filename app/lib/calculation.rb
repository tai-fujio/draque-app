# ゲームバランスに関わる計算をまとめたモジュール
module Calculation
  DAMAGE_PERCENTAGE_RANGE = 36..62
  BRAVE_STATUS_UP_PERCENTAGE_RANGE = 35..55
  BRAVE_STATUS_UP_BONUS_RANGE = 0..2  

  # ダメージ計算
  def damage_calc(attacker:, defender:)
    offense = attacker.offense
    defense = defender.defense
    # 100.0にしないと random_rate の計算結果が整数になるので注意！
    random_rate = rand(DAMAGE_PERCENTAGE_RANGE) / 100.0
    damage = (offense - defense / 2) * random_rate
    # 最小ダメージは 1 とする。
    [damage.to_i, 1].max
  end

  # 勇者のステータス上昇量
  def brave_status_up(level)
    # ステータスアップ量にはランダム性を入れる
    bonus_addition = rand(BRAVE_STATUS_UP_BONUS_RANGE)
    percentage = rand(BRAVE_STATUS_UP_PERCENTAGE_RANGE)
    # 低レベル時は乱数による差が出にくいため，bonus_addition で調整
    bonus_addition + (level * percentage / 100.0).ceil
  end
end
