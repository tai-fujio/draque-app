class User < ApplicationRecord
  after_create :create_initial_setting
  after_create :create_initial_spell
  # userクラスが作成された後に、後述のメソッドが発動

  # 外部のIDを持っている場合はbelong_to,持っていない場合はhas_oneという認識でOK
  has_one :game, dependent: :destroy
  has_one :brave, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def create_initial_setting
    create_brave!(initial_brave)
  end

  def create_initial_spell
    create_game!(initial_spell)
  end


  private 

  def initial_brave
    {
      name:"勇者",
      exp: 0,
      level: 1,
      max_hp: 15,
      offense: 100,
      defense: 100
    }
  end

  def initial_spell
    {
      spell:"hello"
    }
  end

end
