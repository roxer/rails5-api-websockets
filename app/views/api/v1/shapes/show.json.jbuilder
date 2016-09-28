# frozen_string_literal: true
json.extract! @api_v1_shape, :id, :label, :shape_type,
                             :pos_x, :pos_y, :descriptors,
                             :canvas_id, :created_at, :updated_at
