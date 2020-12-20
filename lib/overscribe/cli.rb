require 'overscribe'

require 'thor'

module Overscribe
  class CLI < Thor
    desc 'fetch', 'Fetch specified in config file'
    def fetch
      ModuleSync.fetch
    end

    def self.exit_on_failure?
      true
    end
  end
end
