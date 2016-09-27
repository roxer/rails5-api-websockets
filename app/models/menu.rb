class Menu < ApplicationRecord
  mount_uploader :datafile, MenuUploader

  has_and_belongs_to_many :venues
  has_many   :menu_pages
  belongs_to :event
  belongs_to :place

  self.per_page = 10

  ransacker :json_export do |r|
    r.table[:json_export]
  end

  COLS = %i(
    id
    name
    sponsor
    event_orig
    venue_orig
    place_orig
    physical_description
    occasion
    notes
    call_number
    keywords
    language
    sheduled_on
    location
    location_type
    currency
    currency_symbol
    status
    menu_pages_count
    dishes_count
    place_id
    event_id
  ).freeze
end
