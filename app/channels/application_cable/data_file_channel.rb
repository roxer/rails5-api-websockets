# encoding: utf-8
# frozen_string_literal: true
class DataFileChannel < ApplicationCable::Channel
  def subscribed
    stream_from "data_file_#{params[:data_file_id]}"
  end

  def unsubscribed
  end
end
