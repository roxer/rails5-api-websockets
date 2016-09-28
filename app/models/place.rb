# encoding: utf-8
# frozen_string_literal: true
class Place < ApplicationRecord
  has_many :menus

  self.per_page = 10
end
