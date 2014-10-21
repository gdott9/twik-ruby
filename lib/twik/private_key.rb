class Twik
  class PrivateKey
    def self.generate
      format = [8, 4, 4, 4, 12]
      separator = '-'
      chars = ('A'..'Z').to_a + ('0'..'9').to_a

      format.map do |i|
        i.times.inject('') do |res, j|
          res + chars[Random.rand(chars.length)]
        end
      end.join(separator)
    end
  end
end
