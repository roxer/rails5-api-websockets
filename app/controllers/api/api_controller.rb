module Api
  class ApiController < ApplicationController
    skip_before_filter :verify_authenticity_token
    protect_from_forgery with: :null_session
    before_filter :authenticate
    before_action :set_diagram

    #####################################################################################

    private

    def authenticate
      authenticate_or_request_with_http_basic do |user, password|
        user == "phil" && password == "catspaw"
      end
    end

    def set_diagram
      d = Api::V1::Diagram.find_or_create_by(name: 'default')
      @diagram = "diagram_#{d.id}"
    end
  end
end
