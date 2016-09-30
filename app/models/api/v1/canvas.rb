# encoding: utf-8
# frozen_string_literal: true
class Api::V1::Canvas < ActiveRecord::Base
  belongs_to :diagram, class_name: 'Api::V1::Diagram', foreign_key: 'api_v1_diagram_id'
  has_many :shapes, dependent: :destroy

  after_initialize :set_default_diagram, on: :create

  validates :name, presence: true
  validates :diagram_id, presence: true
  validates :name, on: [:create, :update],
                   uniqueness: {scope: :diagram_id,
                                case_sensitive: false,
                                message: 'has already been taken'}

  #######################################################################################

  private

  def set_default_diagram
    return if persisted?
    self.diagram = Api::V1::Diagram.find_or_create_by(name: 'default')
  end
end
