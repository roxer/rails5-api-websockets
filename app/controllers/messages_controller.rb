# frozen_string_literal: true
class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    render :index
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  rescue ActiveRecord::RecordNotFound
    render json: { error: "not found" }, status: 404
  end

  #######################################################################################

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:name)
  end
end
