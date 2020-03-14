class Brave < ApplicationRecord
  include Calculation
  belongs_to :user, dependent: :destroy

  validates :user_id, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :exp, presence: true
  validates :level, presence: true
  validates :max_hp, presence: true
  validates :offense, presence: true
  validates :defense, presence: true

  # 戦闘中に使用するゲッター・セッターを追加
  attr_accessor :hp, :damage

  # sessionに保存するデータ（戦闘中に必要となるデータ）を作成するメソッド
  # hp は戦闘時の変化に対応できるよう，引数で与えられるようにしておく。
  def session_attributes(hp: self.max_hp)
    attributes.slice('name', 'offense', 'defense').merge('hp' => hp)
  end

  def attack(monster)
    monster.hp -= monster.damage = damage_calc(attacker: self, defender: monster)
    # HPが0以下にならないようにする
    monster.hp = 0 if monster.hp < 0
  end
  def lose_exp(monster_exp)
    # 経験値を減少
    self.exp -= monster_exp / 2
    # 経験値がマイナスにならないようにする
    self.exp = 0 if self.exp < 0
  end
  def current_level
    level = ExpTable.where('exp > ?', self.exp).minimum(:level)
    # レベルが最大を超えたとき（level が nil のとき）の対処をしておく
    level.present? ? level : ExpTable.maximum(:level) + 1
  end

  def status_up(level_up_times)
    level_up_times.times do
      # ステータスアップ量にはランダム性を入れる
      self.max_hp += brave_status_up(self.level)
      self.offense += brave_status_up(self.level)
      self.defense += brave_status_up(self.level)
      self.level += 1
    end
  end
end
