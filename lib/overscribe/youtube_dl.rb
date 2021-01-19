module Overscribe
  module YoutubeDL
    def self.download(url:, args:, options:)
      command = %w[youtube-dl --add-metadata]
      command += %w[--yes-playlist]
      command += %w[--ignore-errors --no-call-home]
      command += %w[--download-archive .youtube-dl.archive]

      command += %w[--get-filename] if options['simulate'] == true
      command += %W[--max-downloads #{options['limit']}] unless options['limit'].nil? || options['limit'].zero?
      command += %W[--output #{options['filename_pattern']}] unless options['filename_pattern'].nil?
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
