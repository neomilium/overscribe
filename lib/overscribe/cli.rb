require 'overscribe'

require 'thor'

module Overscribe
  class CLI < Thor
    desc 'collections [PATTERN]', 'Fetch collections that match pattern'
    option :limit,
           desc: 'Limit downloads per collection',
           type: :numeric,
           default: 1
    def collections(pattern = nil)
      Overscribe.fetch_collections(options.merge(pattern: pattern))
    end


    def self.exit_on_failure?
      true
    end
  end
end
