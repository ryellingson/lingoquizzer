class PlaysController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    @play = Play.new(plays_params)
    @play.game = game
    @play.user = current_user
    authorize @play
    @play.save
    new_total_score = current_user.total_score + @play.score
    current_user.update(total_score: new_total_score)
    head :ok
    # a response that has no content, just a header giving JS a response that the function worked because JS expects something
  end

  private

  def plays_params
    params.require(:play).permit(:count, :score, :time)
  end
end
