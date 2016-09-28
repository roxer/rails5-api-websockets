# encoding: utf-8
# frozen_string_literal: true
class MenuItem < ApplicationRecord
  mount_uploader :datafile, MenuItemUploader
  belongs_to :dish
  belongs_to :menu_page

  COLS = %i(
    id
    menu_page_id
    price
    high_price
    dish_id
    created_at
    updated_at
    xpos
    ypos
  ).freeze
end
