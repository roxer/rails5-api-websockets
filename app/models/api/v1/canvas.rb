class Api::V1::Canvas < ActiveRecord::Base
  belongs_to :diagram
  has_many :shapes, dependent: :destroy

  after_initialize :set_default_diagram, on: :create

  validates :name, presence: true
  validates :diagram_id, presence: true
  validates :name, on: [:create, :update],
                   uniqueness: { scope: :diagram_id,
                                 case_sensitive: false,
                                 message: 'has already been taken' }


  #######################################################################################

  private

  def set_default_diagram
    unless persisted?
      d = Api::V1::Diagram.find_or_create_by(name: 'default')
      self.diagram = d
    end
  end
end
