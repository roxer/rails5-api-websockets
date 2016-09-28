# encoding: utf-8
# frozen_string_literal: true
class Api::V1::ShapesController < ApplicationController
  before_action :set_api_v1_shape, only: [:show, :edit, :destroy]

  swagger_controller :api_v1_shape, "Shapes"

  swagger_api :index do
    summary "Fetches all Shapes items for given Canvas"
    notes "This lists shapes ..."
    param :query, :page, :integer, :optional, "Page number"
    param :query, :canvas_id, :integer, :required, "Canvas ID"
    response :ok, "Success", :Shape
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end
  # GET /api/v1/shapes
  # GET /api/v1/shapes.json
  def index
    @api_v1_shapes = Api::V1::Shape.where(canvas_id: api_v1_shape_params[:canvas_id])
  end

  # GET /api/v1/shapes/1
  # GET /api/v1/shapes/1.json
  def show
  end

  # GET /api/v1/shapes/1/edit
  def edit
  end

  swagger_api :create do
    summary "Creates a new Shape"
    notes "TODO ..." # TODO: ...
    param :form, :canvas_id, :integer, :required, "Canvas ID"
    param :form, :label, :string, :required, "Label"
    param :form, :pos_x, :integer, :required, "Pos_X"
    param :form, :pos_y, :integer, :required, "Pos_Y"
    param_list :form, :shape_type, :string, :required, "Shape Type", %w(Circle Rectangle)
    param :form, :descriptors, :string, :required, "Descriptors"
    response :created, "Success", :Shape
    response :unauthorized
    response :not_acceptable
  end
  # POST /api/v1/shapes
  # POST /api/v1/shapes.json
  def create
    @api_v1_shape = Api::V1::Shape.new(api_v1_shape_params)

    respond_to do |format|
      if @api_v1_shape.save
        format.html do
          redirect_to @api_v1_shape, notice: 'Shape was successfully created.'
        end

        format.json do
          msg = render_to_string(action: 'show', layout: false)
          broadcast("created", JSON.parse(msg))
          render :show, status: :created, location: @api_v1_shape
        end

      else
        format.html { render :new }
        format.json { render json: @api_v1_shape.errors, status: :unprocessable_entity }
      end
    end
  end

  swagger_api :update do
    summary "Updates an existing Shape"
    param :path, :id, :integer, :required, "Shape Id"
    param :form, :label, :string, :optional, "Label"
    param :form, :pos_x, :integer, :optional, "Pos X"
    param :form, :pos_y, :integer, :optional, "Pos Y"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end
  # PATCH/PUT /api/v1/shapes/1
  # PATCH/PUT /api/v1/shapes/1.json
  def update
    respond_to do |format|
      ActiveRecord::Base.transaction do
        # obtain an exclusive lock on the selected row
        @api_v1_shape = Api::V1::Shape.lock.find(params[:id])
        # TODO: test deleting record durring lock for update

        if @api_v1_shape.update(api_v1_shape_params)
          format.html do
            redirect_to @api_v1_shape, notice: 'Shape was successfully updated.'
          end

          format.json do
            msg = render_to_string(action: 'show', layout: false)
            broadcast("updated", JSON.parse(msg))
            render :show, status: :ok, location: @api_v1_shape
          end

        else
          format.html { render :edit }
          format.json { render json: @api_v1_shape.errors, status: :unprocessable_entity }
        end
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: '{"error": "record not found"}', status: 404
  rescue => e
    logger.error "shape update error #{e.message} #{e.backtrace}"
    render json: %({ "error": "something went wrong ... #{e.message}" }), status: 500
  end

  swagger_api :destroy do
    summary "Deletes an existing Shape item"
    param :path, :id, :integer, :required, "Shape Id"
    notes "TODO: ..."
    response :unauthorized
    response :not_found
  end
  # DELETE /api/v1/shapes/1
  # DELETE /api/v1/shapes/1.json
  def destroy
    id = @api_v1_shape.id
    @api_v1_shape.destroy
    respond_to do |format|
      format.html do
        redirect_to api_v1_shapes_url, notice: 'Shape was successfully destroyed.'
      end

      format.json do
        msg = {id: id}
        broadcast("deleted", msg)
        head :no_content
      end
    end
  end

  swagger_model :Shape do
    des = {radius: 10}.to_json
    description "A Shape object."
    property :id, :integer, :required, "Shape Id"
    property :canvas_id, :integer, :required, "Canvas Id"
    property :label, :string, :required, "Label", example: 'label_1'
    property :shape_type, :string, :required, "Shape Type", example: 'Circle'
    property :pos_x, :integer, :required, "Pos X", example: 10
    property :pos_y, :integer, :required, "Pos Y", example: 10
    property :Descriptors, :string, :required, "Descriptors", example: des
  end

  #######################################################################################

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_shape
    @api_v1_shape = Api::V1::Shape.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: '{"error": "record not found"}', status: 404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def api_v1_shape_params
    params.permit(
      :label, :shape_type, :canvas_id, :pos_x,
      :pos_y, :descriptors
    )
  end

  def broadcast(action, msg)
    msg = {action: {event: action, type: 'shape'}, body: msg}.to_json
    ActionCable.server.broadcast(@diagram, msg)
  end
end
