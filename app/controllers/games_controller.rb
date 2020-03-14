class GamesController < ApplicationController
  def index
    @brave = current_user.brave
    @monster = Monster.where('recommended_level <= ?', @brave.level).sample
    session[:brave] = @brave.session_attributes
    session[:monster] = @monster.session_attributes
  end
  def start
    @brave = current_user.brave
    @monster = Monster.find_by(name: session[:monster]['name'])
    session[:brave] = @brave.session_attributes
    session[:monster] = @monster.session_attributes
  end
  def battle
    battle_start
    if @monster.hp <= 0
      # モンスターを倒した場合
      victory_reward
      reappear_monster
    elsif @brave.hp <= 0
      # 勇者が倒れた場合
      defeat_processing
      reappear_monster
    end
     @all_messages = all_messages
  end

  private

  def battle_start
    @brave = Brave.new(session[:brave])
    @monster = Monster.new(session[:monster])
    @brave.attack(@monster)
    session[:monster]['hp'] = @monster.hp
    @monster_damage_messages = Message.damage(attacker: @brave, defender: @monster)
    if @monster.hp.positive?
      @monster.attack(@brave)
      session[:brave]['hp'] = @brave.hp
      @brave_damage_messages = Message.damage(attacker: @monster, defender: @brave)
    end
  end
  def victory_reward
    # データを最新にしてから処理を行う
    @brave = current_user.brave
    # 経験値を追加
    @brave.exp += session[:monster]['exp']# レベルアップしているか判定し，レベルアップしているときはステータスをアップさせ，メッセージを作成する
     # レベルアップしているか判定し，レベルアップしているときはステータスをアップさせ，メッセージを作成する
     level_up_times = @brave.current_level - @brave.level
     if level_up_times > 0
       @brave.status_up(level_up_times)
       @level_up_messages = Message.level_up(@brave)
     end
    # level_up_times = @brave.current_level - @brave.level
    # if level_up_times > 0
    #   @brave.status_up(level_up_times)
    #   @level_up_messages = Message.level_up(@brave)
    # end
    @victory_messages = Message.victory(@monster)
  end
  
  def defeat_processing
    @brave = current_user.brave
    @brave.lose_exp(session[:monster]['exp'])
    # 経験値を減少
    @brave.exp -= session[:monster]['exp'] / 2
    # 経験値がマイナスにならないようにする
    @brave.exp = 0 if @brave.exp < 0
    @defeat_messages = Message.defeat(@brave)
  end
  
  def reappear_monster
    @brave.save
    @monster = Monster.where('recommended_level <= ?', @brave.level).sample
    session[:monster] = @monster.session_attributes
  end

  def all_messages
    [
    @monster_damage_messages,
    @brave_damage_messages,
    @victory_messages,
    @level_up_messages,
    @defeat_messages
  ].flatten.compact
  end
  #   battle_info
  # end

  def battle_info
    puts <<~TEXT
      ========================================
      勇者の攻撃力: #{@brave.offense}
      モンスターの防御力: #{@monster.defense}

      モンスターの受けたダメージ: #{@monster.damage}
      モンスターの残りHP: #{@monster.hp} 
      ----------------------------------------
      モンスターの攻撃力： #{@monster.offense}
      勇者の防御力： #{@brave.defense}

      勇者の受けたダメージ: #{@brave.damage}
      勇者の残りHP： #{@brave.hp} 
      ========================================
    TEXT
  end
end
