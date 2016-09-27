class MenuPage < ApplicationRecord
  mount_uploader :datafile, MenuPageUploader
  belongs_to :menu

  COLS = %i(
    id
    menu_id
    page_number
    image_id
    full_height
    full_width
    uuid
  ).freeze
end
