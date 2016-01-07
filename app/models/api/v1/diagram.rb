class Api::V1::Diagram < ActiveRecord::Base
  has_many :canvases

  validates :name, uniqueness: true
end
