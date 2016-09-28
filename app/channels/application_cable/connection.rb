# frozen_string_literal: true
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
    identified_by :uuid

    def connect
      # self.current_user = find_verified_user
      self.uuid = SecureRandom.uuid
    end

    ####################################################################################

    protected

    def find_verified_user
      if current_user = User.find(cookies.signed[:user_id])
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
