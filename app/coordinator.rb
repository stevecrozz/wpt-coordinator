require './app/coordinator/config'

module Coordinator
  def self.config(params=nil)
    if params
      @config = Coordinator::Config.new(params)
    else
      @config
    end
  end
end
