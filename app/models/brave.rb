class Brave < ApplicationRecord
  include Calculation

  # culcモジュールをmixinする

  belongs_to :user
  
  validates :user_id, presence:true, uniqueness: true
  # uniqueness:一意性
  validates :name, presence: true, length: {maximum: 10}
  validates :exp, presence: true
  validates :level, presence: true
  validates :max_hp, presence: true
  validates :offense, presence: true
  validates :defense, presence: true
  validates :word ,presence: false

  # 戦闘中のゲッタ・セッタ
  attr_accessor :hp, :damage

  # 戦闘中使うデータをsessionに保存する
  def session_attributes(hp: self.max_hp)
    attributes.slice("name","offense","defense").merge("hp" => hp)
    # sliceでattributesの配列の中の指定された部分配列を返す。
    # name,offense,defenseと戦闘で変動するhpを抽出。
  end

  def attack(monster)
    monster.hp -= monster.damage = damage_calc(attacker: self,defender: monster)
    monster.hp = 0 if monster.hp < 0
    # モンスターのHPが0以下になったら0にする。
  end

  def skill_attack(monster)
    monster.hp -= monster.damage = skill_damage_calc(attacker: self,defender: monster)
    monster.hp = 0 if monster.hp < 0
  end


  def spell_1_attack(monster)
    monster.hp -= monster.damage = spell_1_damage_calc(attacker: self,defender: monster)
    monster.hp = 0 if monster.hp < 0
  end

  def spell_2_attack(monster)
    monster.hp -= monster.damage = spell_2_damage_calc(attacker: self,defender: monster)
    monster.hp = 0 if monster.hp < 0
  end

  def spell_3_attack(monster)
    monster.hp -= monster.damage = 100
    monster.hp = 0 if monster.hp < 0
  end

  def spell_attack(monster)
    monster.hp -= monster.damage = 0
    monster.hp = 0 if monster.hp < 0
  end


  def lose_exp(lose_exp)
    self.exp -= lose_exp / 2
    self.exp = 0 if self.exp < 0
  end

  def current_level
    level = ExpTable.where("exp > ?", self.exp).minimum(:level)
    level.present? ? level :ExpTable.maximum(:level) + 1
  end

  def status_up(level_up_timing)
    level_up_timing.times do
      self.max_hp += brave_status_up(self.level)
      self.offense += brave_status_up(self.level)
      self.defense += brave_status_up(self.level)
      self.level += 1
    end
  end

end
