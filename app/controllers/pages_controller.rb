class PagesController < ApplicationController
  before_action :authenticate_user!, only: [ :upload ]
  include PagesHelper
  def index
  end

  def upload
  end

  def upload_game
    unless params[:file].present?
      render :upload, status: :unprocessable_entity, alert: "You're missing to upload the .txt file"
    end
    file_ext = File.extname(params[:file])
    unless file_ext == ".txt"
      flash[:alert] = "Wrong file format, please upload a .txt file"
      render turbo_stream: turbo_stream.action(:redirect, request.referer)
      return
    end
    file_content = File.read(params[:file])
    title = extract_title(file_content)
    dimensions = extract_dimensions(file_content)
    rows = dimensions[:rows]
    columns = dimensions[:cols]
    matrix = extract_matrix(file_content)
    if is_matrix_valid?(file_content, rows, columns)
      @game = Game.create!(rows: rows, columns: columns, matrix: matrix, user: current_user, title: title)
      if @game.save
        flash[:notice] = "Game created correctly, now you can play the game!"
        render turbo_stream: turbo_stream.action(:redirect, game_path(@game))
      else
        render :upload, status: :unprocessable_entity, alert: "Invalid file format"
      end
    else
      render :upload, status: :unprocessable_entity, alert: "Invalid file format"
    end
  end
end
