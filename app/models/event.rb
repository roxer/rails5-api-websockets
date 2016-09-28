# frozen_string_literal: true
class Event < ApplicationRecord
  has_many :menus

  self.per_page = 10
end
