require 'overscribe'

require 'thor'

module Overscribe
  class CLI < Thor
    desc 'fetch-all', 'Fetch all collections'
    option :limit,
           desc: 'Limit downloads per collection',
           type: :numeric,
           default: 1
    def fetch_all
      Overscribe.fetch(options)
    end

    desc 'fetch PATTERN', 'Fetch collection that match pattern'
    option :limit,
           desc: 'Limit downloads per collection',
           type: :numeric,
           default: 1
    def fetch(pattern)
      Overscribe.fetch(options.merge(pattern: pattern))
    end

    def self.exit_on_failure?
      true
    end
  end
end
