require 'overscribe'

require 'thor'

module Overscribe
  class CLI < Thor
    class Collections < Thor
      class_option :simulate,
        desc: 'Do not download',
        aliases: '-s',
        type: :boolean,
        default: false
      desc 'fetch [PATTERN]', 'Fetch collections that start with PATTERN'
      option :limit,
        desc: 'Limit downloads per collection',
        type: :numeric,
        default: 1
      def fetch(pattern = nil)
        Overscribe.fetch_collections(options.merge(pattern: pattern))
      end

      desc 'list [PATTERN]', 'Fetch collections that start with PATTERN'
      def list(pattern = nil)
        puts Overscribe.list_collections(options.merge(pattern: pattern)).keys.join "\n"
      end
    end

    desc 'oneshot URL', 'Fetch medias from URL'
    option :profile,
           desc: <<~DESC,
             Use the specified profile to download medias
             #{' ' * 37}#   Profiles: #{Overscribe.profiles.map { |key, _| key }}
           DESC
           aliases: '-p',
           required: true
    option :collection,
           desc: 'Generate a named collection',
           type: :string
    option :extra_args,
           desc: 'Add extra arguments to youtube-dl',
           aliases: '-x',
           type: :string
    def oneshot(url)
      Overscribe.fetch_oneshot(url, options)
    end

    desc 'collections', 'Play with collections'
    subcommand 'collections', CLI::Collections

    def self.exit_on_failure?
      true
    end
  end
end
