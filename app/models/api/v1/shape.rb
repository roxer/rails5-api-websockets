# encoding: utf-8
# frozen_string_literal: true
require 'json-schema'

class Api::V1::Shape < ActiveRecord::Base
  belongs_to :canvas

  JSON_SCHEMA = Rails.root.join('spec', 'support', 'api', 'schemas').to_s

  validates :label, on: [:create, :update],
                    uniqueness: {case_sensitive: false,
                                 scope: :canvas_id,
                                 message: 'has already been taken'}
  validates :label, presence: true
  validates :pos_x, presence: true
  validates :pos_y, presence: true
  validates :pos_x, numericality: {only_integer: true}
  validates :pos_y, numericality: {only_integer: true}
  validates :descriptors, presence: true
  # json: { message: ->(errors) { errors }, schema: -> { check_descriptors } }
  validates :shape_type, presence: true
  validates :shape_type, inclusion: {in: %w(Circle Rectangle),
                                     message: "%{value} is not a valid shape type"}
  validates :canvas_id, presence: true
  validate  :check_descriptors

  def check_descriptors
    unless shape_type.blank?
      schema = File.read JSON_SCHEMA + "/#{shape_type.downcase}.json"
      unless JSON::Validator.validate(schema, descriptors, strict: false)
        errors.add(:descriptors, 'Shape must be valid to json schema - http://ow.ly/WSpIN')
      end
    end
  rescue
    nil # TODO: ...
  end
end
