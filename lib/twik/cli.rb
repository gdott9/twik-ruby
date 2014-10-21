require 'twik'
require 'twik/cli/config'
require 'twik/cli/options'

class Twik
  class Cli
    attr_reader :config

    def initialize(args)
      @config = Config.new(args)
    end

    def twik
      @twik ||= Twik.new(config.privatekey, length: config.length, type: config.type.to_sym)
    end

    def run
      masterkey = ask('Master key: ')
      puts twik.generate(config.tag, masterkey)
    end

    def ask(prompt)
      print prompt
      res = STDIN.noecho(&:gets).chomp
      puts

      res
    end
  end
end
