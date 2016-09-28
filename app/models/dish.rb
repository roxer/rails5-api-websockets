# frozen_string_literal: true
class Dish < ApplicationRecord
  mount_uploader :datafile, DishUploader
  belongs_to :menu_item

  COLS = %i(
    id
    description
    first_appeared
    highest_price
    last_appeared
    lowest_price
    menus_appeared_count
    name
    times_appeared_count
  ).freeze
end
