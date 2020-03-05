class GamesController < ApplicationController
  def index
    @brave = current_user.brave
    @monster = Monster.all.sample
  end

  def start
    
  end
end
