# encoding: utf-8
# frozen_string_literal: true
class DataFilesController < ApplicationController
  before_action :set_data_file, only: [:show]

  def index
    @data_files = DataFile.all
  end

  def new
    @data_file = DataFile.new
  end

  def show
    gon.push(data_file_id: @data_file.id)
  end

  def create
    df = DataFile.create(data_file_params)

    ImporterJob.perform_later(df.id)

    redirect_to data_file_url(df)
  end

  private

  def data_file_params
    params.require(:data_file).permit!
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_data_file
    @data_file = DataFile.find(params[:id])
  end
end
