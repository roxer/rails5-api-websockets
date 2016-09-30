# encoding: utf-8
# frozen_string_literal: true
require 'csv'

class ImporterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    msg = {action: {event: 'started', type: 'import'}, body: 'process job'}.to_json
    ActionCable.server.broadcast("data_file_#{args.first}", msg)

    CSVImportParser.new(args.first).process
  rescue => ex
    msg = {
      action: {
        event: 'fatal',
        type:  'import'
      },
      body: "an exception has occured: #{ex.message}",
    }.to_json

    ActionCable.server.broadcast("data_file_#{args.first}", msg)
    logger.error "something went wrong #{ex.backtrace}: #{ex.message} (#{ex.class})"
  ensure
    msg = {action: {event: 'finished', type: 'import'}, body: 'process job exited'}.to_json
    ActionCable.server.broadcast("data_file_#{args.first}", msg)
  end
end
