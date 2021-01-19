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

    desc 'oneshot URL', 'Fetch medias from URL'
    option :profile,
           desc: <<~DESC,
             Use the specified profile to download medias
             #{' ' * 37}#   Profiles: #{Overscribe.profiles.map { |key, _| key }}
           DESC
           aliases: '-p',
           required: true
    def oneshot(url)
      Overscribe.fetch_oneshot(url, options)
    end

    def self.exit_on_failure?
      true
    end
  end
end
