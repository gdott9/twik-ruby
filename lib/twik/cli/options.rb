require 'optparse'

class Twik
  class Cli
    class Options
      def self.parse(args)
        options = {}

        parser = ::OptionParser.new do |opts|
          opts.banner = 'Usage: twik [options] tag'

          opts.separator ''
          opts.separator 'Specific options:'

          opts.on('-l', '--length LENGTH', 'length of generated password (4-26). Default: 16') do |length|
            options['length'] = length.to_i
          end

          opts.on('-p', '--profile PROFILE', "profile to use. Default: 'default'") do |profile|
            options['profile'] = profile
          end

          opts.on('-t', '--type TYPE', Twik::TYPE,
                  "type of password:", "  #{Twik::TYPE.join(', ')}", "  Default: alphanumeric_and_special_chars") do |type|
            options['type'] = type.to_sym
          end

          opts.separator ''
          opts.separator 'Common options:'

          opts.on_tail('-h', '--help', 'Show this message') do
            puts opts
            exit
          end

          opts.on_tail('--version', 'Show version') do
            puts "#{opts.program_name} #{Immoconv::VERSION}"
            exit
          end
        end

        begin
          parser.parse!(args)
        rescue OptionParser::MissingArgument, OptionParser::InvalidOption => e
          puts e.message
          puts parser
          exit
        end

        options['tag'] = args.shift

        options
      end
    end
  end
end
