class Api::V1::DiagramsController < ApplicationController

  # GET /api/v1/diagrams
  # GET /api/v1/diagrams.json
  def index
    @api_v1_diagrams = Api::V1::Diagram.all
  end


end
