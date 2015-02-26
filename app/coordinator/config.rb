require 'ostruct'

module Coordinator
  class Config < OpenStruct
    attr_reader :fog_connection,
      :fog_directory,
      :in_memory_db,
      :logger,
      :persistent_db

    def initialize(params)
      @logger = Logger.new($stdout)
      @fog_connection = Fog::Storage.new(JSON.parse(
        params['FOG_CONNECTION'], symbolize_names: true))
      @fog_directory = @fog_connection.directories.get(params['FOG_DIRECTORY'])
      @in_memory_db = Sequel.sqlite '', loggers: [@logger]
      @persistent_db = Sequel.connect params['DATABASE_URL'], loggers: [@logger]
    end
  end
end
