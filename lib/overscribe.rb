require 'overscribe/version'

require 'yaml'
require 'English'

require 'byebug'

module Overscribe
  class Error < StandardError; end

  def self.fetch(cli_options)
    collections = config['collections']

    collections.select! do |collection, options|
      if cli_options['pattern'].nil?
        # Remove manually synced
        !options['manual']
      else
        # Select by pattern
        collection.start_with? cli_options['pattern']
      end
    end

    collections.each do |collection, options|
      directory = config['directories'][options['mediatype']]
      directory = File.expand_path directory
      directory = File.join directory, collection
      puts directory
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
end

module Overscribe
  module YoutubeDL
    def self.download(url:, mediatype:, options:)
      args = case mediatype
             when :audio
               %w[--format bestaudio --extract-audio]
             when :video
               %w[--format bestvideo+bestaudio]
             else
               raise NotImplementedError
             end
      args += %W[--max-downloads #{options['limit']}] unless (options['limit']).zero?
      args += %W[--output #{options['filename_pattern']}] unless options['filename_pattern'].nil?

      command = %w[youtube-dl --add-metadata --yes-playlist]
      command += %w[--write-info-json]
      command += %w[--simulate] if options['noop'] == true
      command += %w[--download-archive .youtube-dl.archive]
      command += %w[--ignore-errors]
      command += %w[--no-call-home]
      command += args
      command += [url]
      run command
    end

    def self.run(command)
      puts "Running '#{command}'"
      system(*command)
      status = $CHILD_STATUS
      puts status
    end
  end
end
