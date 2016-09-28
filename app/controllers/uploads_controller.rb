# frozen_string_literal: true
class UploadsController < ApplicationController
  def index
    @venues = Venue.all
  end

  def create
    %i(:menu, :dish, :menu_page, :menu_item).each do |name|
      next unless params[:name]
      path = Rails.root.join('db', 'uploads', name.to_s.camelcase + '.csv')

      File.open(path, 'wb') do |file|
        file.write(params[name].read)
      end

      system("split -l 50000 #{path} ./db/uploads/mi_") if name == :menu_item
    end

    ImporterJob.perform_later

    redirect_to uploads_url
  end
end
