module Overscribe
  module YoutubeDL
    MEDIATYPE_ARGS = {
      audio: %w[--format bestaudio --extract-audio],
      video: %w[--format bestvideo+bestaudio],
    }.freeze

    def self.download(url:, mediatype:, options:)
      command = %w[youtube-dl --add-metadata --yes-playlist]
      command += %w[--ignore-errors --no-call-home]
      command += %w[--download-archive .youtube-dl.archive]

      command += %w[--simulate] if options['noop'] == true
      command += %W[--max-downloads #{options['limit']}] unless options['limit'].nil? || options['limit'].zero?
      command += %W[--output #{options['filename_pattern']}] unless options['filename_pattern'].nil?
      command += MEDIATYPE_ARGS[mediatype]

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
