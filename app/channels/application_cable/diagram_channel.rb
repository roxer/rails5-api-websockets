# frozen_string_literal: true
# app/channels/appearance_channel.rb
class DiagramChannel < ApplicationCable::Channel
  def subscribed
    stream_from "diagram_#{params[:diagram_id]}"
  end

  def unsubscribed
  end
end
