# frozen_string_literal: true
class Venue < ApplicationRecord
  has_and_belongs_to_many :menus
end
