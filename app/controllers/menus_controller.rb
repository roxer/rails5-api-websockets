# encoding: utf-8
# frozen_string_literal: true
class MenusController < ApplicationController
  def index
    @search = ransack_params
    @menus = ransack_result

    # REVIEW: export to json if user opts to with checkbox
    render formats: :json if (params[:q][:json_export].to_i == 1 rescue false)
  end

  private

  def ransack_params
    q = params[:q]

    # REVIEW: limit results with nested resources
    if (venue_id = params[:venue_id])
      Menu.joins(:menus_venues)
          .where(menus_venues: {venue_id: venue_id})
          .ransack(q)

    elsif (event_id = params[:event_id])
      Menu.where(event_id: event_id)
          .ransack(q)

    elsif (place_id = params[:place_id])
      Menu.where(place_id: place_id)
          .ransack(q)

    else
      Menu.ransack(q)
    end
  end

  def ransack_result
    @search.result.page(params[:page])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @menu = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.fetch(:menu, {})
  end
end
