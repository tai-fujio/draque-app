# 計算処理モジュール
# modelでincludeでmixin（取り込む）する。
module Calculation
  DAMAGE_PERCENTAGE_RANGE = 30..60

  def damage_calc(attacker:,defender:)
    offense = attacker.offense
    defense = defender.defense
    # 割合にしたいので100で割る。ランダム値が50なら 0.5=50% になる
    random_rate = rand(DAMAGE_PERCENTAGE_RANGE) / 100.0
    # atk:10,def:4,random_rate:0.5なら(10-4/2)*0.5=4のダメージ
    damage = (offense - defense / 2) * random_rate
    # maxメソッド：[,]内の中から一番大きい数字を返す。
    # damageが１より小さくなっても１はの方が取り出されるので最小ダメージが１となる。
    [damage.to_i, 1].max
  end

end
