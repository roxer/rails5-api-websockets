class Api::V1::CanvasesController < ApplicationController
  before_action :set_api_v1_canvas, only: [:show, :edit, :update, :destroy]

  swagger_controller :api_v1_canvas, "Canvases"

  swagger_api :index do
    summary "Fetches all Canvases items"
    notes "This lists all canvases ..."
    param :query, :page, :integer, :optional, "Page number"
    response :ok, "Success", :Canvas
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end
  # GET /api/v1/canvases
  # GET /api/v1/canvases.json
  def index
    @api_v1_canvases = Api::V1::Canvas.all
    render json: @api_v1_canvases
  end

  swagger_api :show do
    summary "Fetches a single Canvas item"
    param :path, :id, :integer, :optional, "Canvas Id"
    response :ok, "Success", :Book
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  # GET /api/v1/canvases/1
  # GET /api/v1/canvases/1.json
  def show
  end

  swagger_api :create do
    summary "Creates a new Canvas"
    param :form, :name, :string, :required, "Name"
    response :created, "Success", :Canvas
    response :unauthorized
    response :not_acceptable
  end
  # POST /api/v1/canvases
  # POST /api/v1/canvases.json
  def create
    @api_v1_canvas = Api::V1::Canvas.new(api_v1_canvas_params)
    @api_v1_canvas.diagram_id = 1

    respond_to do |format|
      if @api_v1_canvas.save
        format.html do
          redirect_to @api_v1_canvas, notice: 'Canvas was successfully created.'
        end

        format.json do
          msg = render_to_string(action: 'show', layout: false)
          broadcast("created", JSON.parse(msg))

          render :show, status: :created, location: @api_v1_canvas
        end

      else
        format.html { render :new }
        format.json do
          render json: @api_v1_canvas.errors, status: :unprocessable_entity
        end

      end
    end
  rescue => e
    logger.error "canvas create error #{e.message} #{e.backtrace}"
    render json: '{"error": "something went wrong ..."}', status: 500
  end

  # TODO
  # PATCH/PUT /api/v1/canvases/1
  # PATCH/PUT /api/v1/canvases/1.json
  def update
    respond_to do |format|
      if @api_v1_canvas.update(api_v1_canvas_params)
        format.html do
          redirect_to @api_v1_canvas, notice: 'Canvas was successfully updated.'
        end

        format.json { render :show, status: :ok, location: @api_v1_canvas }
      else
        format.html { render :edit }
        format.json { render json: @api_v1_canvas.errors, status: :unprocessable_entity }
      end
    end
  end

  swagger_api :destroy do
    summary "Deletes an existing Canvas item"
    param :path, :id, :integer, :required, "Canvas Id"
    response :unauthorized
    response :not_found
  end
  # DELETE /api/v1/canvases/1
  # DELETE /api/v1/canvases/1.json
  def destroy
    id = @api_v1_canvas.id
    @api_v1_canvas.destroy
    respond_to do |format|
      format.html do
        redirect_to api_v1_canvases_url, notice: 'Canvas was successfully destroyed.'
      end

      format.json do head :no_content
        msg = { id: id }
        broadcast("deleted", msg)
      end
    end
  end

  ######################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_canvas
      @api_v1_canvas = Api::V1::Canvas.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: '{"error": "record not found"}', status: 404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_canvas_params
      params.permit(:name)
    end

    def broadcast(action, msg)
      msg = { action => msg }.to_json

      ActionCable.server.broadcast("diagram_1", msg)
    end
end

