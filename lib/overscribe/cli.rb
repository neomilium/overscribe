require 'overscribe'

require 'thor'

module Overscribe
  class CLI < Thor
    class_option :simulate,
                 desc: 'Do not download',
                 aliases: '-s',
                 type: :boolean,
                 default: false
    desc 'collections [PATTERN]', 'Fetch collections that start with PATTERN'
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
