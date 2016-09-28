# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # before_action :set_diagram

  #######################################################################################

  private

  def set_diagram
    d = Api::V1::Diagram.find_or_create_by(name: 'default')
    @diagram = "diagram_#{d.id}"
  end
end
