class Api::V1::Shape < ActiveRecord::Base
  belongs_to :canvas

  validates :label, on: [:create, :update],
                    uniqueness: { case_sensitive: false,
                                  scope: :canvas_id,
                                  message: 'has already been taken' }
  validates :label, presence: true
  validates :pos_x, presence: true
  validates :pos_y, presence: true
  validates :pos_x, numericality: { only_integer: true }
  validates :pos_y, numericality: { only_integer: true }
  validates :descriptors, presence: true
  validates :shape_type, presence: true
  validates :shape_type, inclusion: { in: %w(Circle Rectangle),
                                      message: "%{value} is not a valid shape type" }
  validates :canvas_id, presence: true
end
