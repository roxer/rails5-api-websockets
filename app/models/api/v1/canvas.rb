class Api::V1::Canvas < ActiveRecord::Base
  belongs_to :diagram
  has_many   :shapes

  before_validation :set_default_diagram

  #######################################################################################
  private

    def set_default_diagram
      d = Api::V1::Diagram.find_by_name('default')
      self.diagram = d if d.present?
    end

end
