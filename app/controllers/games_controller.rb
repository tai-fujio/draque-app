class GamesController < ApplicationController


  def index
    # @game = current_user.game
    # ここで@game作っておかないと、form_withで使うものがなくなりエラー出る
    @brave = current_user.brave
    # @monster = Monster.where("recommended_level <= ?",@brave.level).sample
    @monster = Monster.all.sample
    # recommended_levelがbrave.levelより低いものをランダムで
    session[:brave]= @brave.session_attributes
    session[:monster]=@monster.session_attributes
  end

  # def update
  #   @game = current_user.game
  #   @game.update!(game_params)
  # end

  def start
    # @game = current_user.game
    # これ入れるとデータベース更新されない
    @brave = current_user.brave
    @monster = Monster.find_by(name: session[:monster]["name"])
    session[:brave]= @brave.session_attributes
    session[:monster]= @monster.session_attributes
  end


  def exit
    @exit_message = Message.exit
    @brave = current_user.brave
    # @monster = Monster.where("recommended_level <= ?",@brave.level).sample
    @monster = Monster.all.sample
    finish_battle
  end

  def battle
    battle_start
    # モンスターか勇者のHPが０以下になった時の処理
    battle_process
    @all_messages = all_messages
  end

  def skill
    skill_battle_start
    battle_process
    @all_messages = all_messages
  end

  def spell
    @brave = current_user.brave
    @word = @brave.word
    spell_battle_start
    battle_process
    @all_messages = all_messages
  end


  private
    def game_params
      params.require(:game).permit(:spell)
    end

    def battle_process
      if @monster.hp <= 0
        victory_brave
        finish_battle
      elsif @brave.hp <= 0
        lose_brave
        finish_battle
      end
    end

    def battle_start
      @brave = Brave.new(session[:brave])
      @monster = Monster.new(session[:monster])
      @brave.attack(@monster)
      session[:monster]["hp"] = @monster.hp
      # モンスターhpの更新
      @monster_damage_messages = Message.damage(attacker:@brave, defender:@monster)
      if @monster.hp.positive?
        # hpが0以上か確認する。0以上なら処理実行
        @monster.attack(@brave)
        # 勇者HPの更新
        session[:brave]["hp"] = @brave.hp
        @brave_damage_messages = Message.damage(attacker:@monster, defender:@brave)
      end
      
      battle_info
    end

    def skill_battle_start
      @brave = Brave.new(session[:brave])
      @monster = Monster.new(session[:monster])
      @brave.skill_attack(@monster)
      session[:monster]["hp"] = @monster.hp
      # モンスターhpの更新
      @monster_damage_messages = Message.damage(attacker:@brave, defender:@monster)
      if @monster.hp.positive?
        # hpが0以上か確認する。0以上なら処理実行
        @monster.attack(@brave)
        # 勇者HPの更新
        session[:brave]["hp"] = @brave.hp
        @brave_damage_messages = Message.damage(attacker:@monster, defender:@brave)
      end
      
      battle_info
    end

    def spell_battle_start
      @brave = Brave.new(session[:brave])
      @monster = Monster.new(session[:monster])
      if @word == "メラ"
        @brave.spell_1_attack(@monster)
      elsif @word == "ギラ"
        @brave.spell_2_attack(@monster)
      elsif @word == "ギガスラッシュ"
        @brave.spell_3_attack(@monster)
      else
        @brave.spell_attack(@monster)
      end
      session[:monster]["hp"] = @monster.hp
      # モンスターhpの更新
      @monster_damage_messages = Message.damage(attacker:@brave, defender:@monster)
      if @monster.hp.positive?
        # hpが0以上か確認する。0以上なら処理実行
        @monster.spell_attack(@brave)
        # 勇者HPの更新
        session[:brave]["hp"] = @brave.hp
        @brave_damage_messages = Message.damage(attacker:@monster, defender:@brave)
      end
      
      battle_info
    end




      def battle_info
        # ヒアドキュメント：複数行の出力ができる。今回の場合outputまで
        puts <<~output
          =======================================
          勇者の攻撃力:#{@brave.offense}
          モンスターの防御力:#{@monster.defense}

          モンスタの受けたダメージ:#{@monster.damage}
          モンスターの残りHP:#{@monster.hp}
          ---------------------------------------
          モンスターの攻撃力:#{@monster.offense}
          勇者の防御力:#{@brave.defense}

          勇者の受けたダメージ:#{@brave.damage}
          勇者の残りHP:#{@brave.hp}
          =======================================
        output
      end
    
    def victory_brave
      # データを最新に
      @brave = current_user.brave
      # 経験値追加
      @brave.exp += session[:monster]["exp"]
      level_up_timing = @brave.current_level - @brave.level
      if level_up_timing > 0
        @brave.status_up(level_up_timing)
        @level_up_message = Message.level_up(@brave)
      end
      @victory_messages = Message.victory(@monster)
    end

    def lose_brave
      @brave = current_user.brave
      @brave.lose_exp(session[:monster]["exp"])
      @lose_messages = Message.lose(@brave)
    end

    def finish_battle
      @brave.save
      # @monster = Monster.where("recommended_level <= ?",@brave.level).sample
      @monster = Monster.all.sample
      session[:monster] = @monster.session_attributes
    end

    def all_messages
      [
        @monster_damage_messages,
        @brave_damage_messages,
        @level_up_messages,
        @victory_messages,
        @lose_messages
      ].flatten.compact
      # 多重配列構造を１次的に変換し、nilを取り除く
      
    end

end
