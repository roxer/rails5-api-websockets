class Place < ApplicationRecord
  has_many :menus

  self.per_page = 10
end