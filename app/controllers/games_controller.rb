class GamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def index
    @games = Game.all.where(user: current_user)
  end

  def show
    @game = Game.find(params[:id])
  end

  def next_generation
    game = Game.find(params[:game_id])
    new_matrix = game.next_generation
    old_title_index = game.title.split(" ").last.to_i
    new_title = "Generation #{old_title_index + 1}"
    game.update_attribute("matrix", new_matrix)
    game.update_attribute("title", new_title)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("game", partial: "components/game_grid", locals: { game: game }) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("animation_controls", partial: "components/pause_game_button") }
    end
  end
end
