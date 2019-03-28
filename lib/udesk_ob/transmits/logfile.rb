module UdeskOb
  module Transmits
    # MessageQueue encapsulate redis pub/sub.
    class Logfile
      CONFIGS = %i[path].freeze

      def initialize
        config = UdeskOb::Config.instance
        @file = open_file(config.options[:path])
        @mutex = Mutex.new
      end

      def write(content)
        @mutex.synchronize do
          @file.write(content + "\n")
        end
      end

      private

      def open_file(filename)
        file = File.open(filename, (File::WRONLY | File::APPEND))
        file.sync = true
        file
      rescue Errno::ENOENT
        create_file(filename)
      end

      def create_file(filename)
        begin
          mode = File::WRONLY | File::APPEND | File::CREAT | File::EXCL
          file = File.open(filename, mode)
          file.flock(File::LOCK_EX)
          file.sync = true
          file.flock(File::LOCK_UN)
        rescue Errno::EEXIST
          # file is created by another process
          file = open_file(filename)
        end
        file
      end
    end
  end
end
