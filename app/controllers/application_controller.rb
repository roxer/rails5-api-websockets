class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_diagram

  #######################################################################################
  private

    def set_diagram
      @diagram = "diagram_1"
    end

end
