require 'overscribe/version'
require 'overscribe/youtube_dl'

require 'yaml'
require 'English'

require 'byebug'

module Overscribe
  class Error < StandardError; end

  def self.fetch_collections(cli_options)
    collections = collections(pattern: cli_options['pattern'])

    collections.each do |collection, options|
      directory = File.join target_directory(mediatype: options['mediatype']), collection
      FileUtils.mkdir_p directory
      FileUtils.chdir(directory) do
        YoutubeDL.download url: options['url'], mediatype: options['mediatype'].to_sym,
                           options: cli_options.merge(options)
      end
    end
  end

  def self.config
    filename = File.expand_path '~/.overscribe.yaml'
    YAML.safe_load(File.read(filename))
  end

  def self.collections(pattern:)
    collections = config['collections']

    collections.select! do |collection, options|
      if pattern.nil?
        # Remove manually synced
        !options['manual']
      else
        # Select by pattern
        collection.start_with? pattern
      end
    end
  end

  def self.target_directory(mediatype:)
    File.expand_path config['directories'][mediatype]
  end
end
