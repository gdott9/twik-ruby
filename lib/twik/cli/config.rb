require 'twik/private_key'

require 'xdg'
require 'yaml'

class Twik
  class Cli
    class Config
      CONFIG_FILE = [XDG['CONFIG_HOME'], 'twik', 'config.yml'].join(File::SEPARATOR)

      def self.default
        {
          'profiles' => {
            'default' => {
              'privatekey' => Twik::PrivateKey.generate,
              'length' => 16,
              'type' => 'alphanumeric_and_special_chars',
            }
          }
        }
      end

      attr_reader :yaml, :args

      def initialize(args)
        file = File.new(CONFIG_FILE)
        @args = Options.parse(args)
        @yaml = YAML.load_file(file.path)
      end

      def profile
        args['profile'] || 'default'
      end

      def options
        @options ||= yaml['profiles'][profile].merge(args)
      end

      def method_missing(symbol)
        options.key?(symbol.to_s) ? options[symbol.to_s] : super
      end

      class File
        attr_reader :path

        def initialize(path)
          @path = path
          create unless ::File.exist?(path)
        end

        private

        def create
          directory = ::File.dirname(path)
          ::FileUtils.mkdir_p directory unless ::File.directory?(directory)

          ::File.open(path, 'w') do |file|
            file.write(YAML.dump(Twik::Cli::Config.default))
          end
        end
      end
    end
  end
end
