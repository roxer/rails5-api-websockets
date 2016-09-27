require 'csv'

class ImporterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    msg = { action: { event: 'started', type: 'import' }, body: 'process job' }.to_json
    ActionCable.server.broadcast("data_file_#{args.first}", msg)

    CSVImportParser.new(args.first).process
  rescue => ex
    logger.error "something went wrong #{ex.backtrace}: #{ex.message} (#{ex.class})"
  end
end
