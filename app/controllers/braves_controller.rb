class BravesController < ApplicationController
  def update
    @brave = current_user.brave
    @brave.update!(brave_params)
  end

  private

  
  def brave_params
    params.require(:brave).permit(:name,:word)
  end
end
