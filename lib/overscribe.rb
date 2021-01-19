require 'overscribe/version'
require 'overscribe/youtube_dl'

require 'active_support'
require 'active_support/core_ext/hash/deep_merge' # Hash#deep_merge

require 'yaml'
require 'English'

require 'byebug'

module Overscribe
  class Error < StandardError; end

  def self.fetch_collections(cli_options)
    collections = collections(pattern: cli_options['pattern'])

    collections.each do |collection, options|
      puts ">>> #{collection}"
      options = profile(name: options['profile']).deep_merge(options).deep_merge(cli_options)

      directory = File.expand_path collection, options['directory']
      FileUtils.mkdir_p directory
      FileUtils.chdir(directory) do
        YoutubeDL.download url: options['url'], args: options['youtubedl_args'], options: options
      end
    end
  end

  def self.fetch_oneshot(url, cli_options)
    profile = profile(name: cli_options['profile'])
    options = profile.deep_merge cli_options

    directory = File.expand_path options['directory']
    FileUtils.mkdir_p directory
    FileUtils.chdir(directory) do
      YoutubeDL.download url: url, args: profile['youtubedl_args'], options: options
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

  DEFAULT_PROFILES = {
    'audio' => {
      'youtubedl_args' => %w[--format bestaudio --extract-audio],
    },
    'video' => {
      'youtubedl_args' => %w[--format bestvideo+bestaudio],
    },
  }.freeze
  def self.profiles
    DEFAULT_PROFILES.deep_merge config['profiles']
  end

  def self.profile(name:)
    profiles[name]
  end
end
