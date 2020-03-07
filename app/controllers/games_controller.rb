class GamesController < ApplicationController
  def index
    @brave = current_user.brave
    @monster = Monster.where("recommended_level <= ?",@brave.level).sample
    # @monster = Monster.all.sample
    # recommended_levelがbrave.levelより低いものをランダムで
    session[:brave]= @brave.session_attributes
    session[:monster]=@monster.session_attributes
  end

  def start
    @brave = current_user.brave
    @monster = Monster.find_by(name: session[:monster]["name"])
    session[:brave]= @brave.session_attributes
    session[:monster]= @monster.session_attributes
  end

  def battle
    battle_start

    if @monster.hp <= 0
      victory_brave
      finish_battle
    elsif @brave.hp <= 0
      lose_brave
      finish_battle
    end
    
    @all_messages = all_messages

  end

  private

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
      @brave = current_user.brave
      @brave.exp += session[:monster]["exp"]
      @victory_messages = Message.victory(@monster)
    end

    def lose_brave
      @brave = current_user.brave
      @brave.lose_exp(session[:monster]["exp"])
      @lose_messages = Message.lose(@brave)
    end

    def finish_battle
      @brave.save
      @monster = Monster.where("recommended_level <= ?",@brave.level).sample
      # @monster = Monster.all.sample
      session[:monster] = @monster.session_attributes
    end

    def all_messages
      [
        @monster_damage_messages,
        @brave_damage_messages,
        @victory_messages,
        @lose_messages
      ].flatten.compact
      # 多重配列構造を１次的に変換し、nilを取り除く
      
    end

end
