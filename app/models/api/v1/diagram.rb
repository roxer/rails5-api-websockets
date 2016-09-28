# encoding: utf-8
# frozen_string_literal: true
class Api::V1::Diagram < ActiveRecord::Base
  has_many :canvases

  validates :name, uniqueness: true
end
