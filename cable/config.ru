# encoding: utf-8
# frozen_string_literal: true
require ::File.expand_path('../../config/environment', __FILE__)
Rails.application.eager_load!

# require 'action_cable/process/logging'

run ActionCable.server
