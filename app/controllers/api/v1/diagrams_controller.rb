class Api::V1::DiagramsController < ApplicationController
  before_action :set_api_v1_diagram, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/diagrams
  # GET /api/v1/diagrams.json
  def index
    @api_v1_diagrams = Api::V1::Diagram.all
  end

  # GET /api/v1/diagrams/1
  # GET /api/v1/diagrams/1.json
  def show
  end

  # GET /api/v1/diagrams/new
  def new
    @api_v1_diagram = Api::V1::Diagram.new
  end

  # GET /api/v1/diagrams/1/edit
  def edit
  end

  # POST /api/v1/diagrams
  # POST /api/v1/diagrams.json
  def create
    @api_v1_diagram = Api::V1::Diagram.new(api_v1_diagram_params)

    respond_to do |format|
      if @api_v1_diagram.save
        format.html { redirect_to @api_v1_diagram, notice: 'Diagram was successfully created.' }
        format.json { render :show, status: :created, location: @api_v1_diagram }
      else
        format.html { render :new }
        format.json { render json: @api_v1_diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/diagrams/1
  # PATCH/PUT /api/v1/diagrams/1.json
  def update
    respond_to do |format|
      if @api_v1_diagram.update(api_v1_diagram_params)
        format.html { redirect_to @api_v1_diagram, notice: 'Diagram was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_v1_diagram }
      else
        format.html { render :edit }
        format.json { render json: @api_v1_diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/diagrams/1
  # DELETE /api/v1/diagrams/1.json
  def destroy
    @api_v1_diagram.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_diagrams_url, notice: 'Diagram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_diagram
      @api_v1_diagram = Api::V1::Diagram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_diagram_params
      params.require(:api_v1_diagram).permit(:name)
    end
end
