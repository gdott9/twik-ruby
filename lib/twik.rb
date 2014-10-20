require 'twik/version'
require 'twik/exceptions'
require 'openssl'
require 'base64'

class Twik
  TYPE = %i{alphanumeric_and_special_chars alphanumeric numeric}

  attr_accessor :privatekey, :length, :type

  def initialize(privatekey, length: 16, type: :alphanumeric_and_special_chars)
    raise UnknownType.new("type should be one of (#{TYPE.join(', ')})")  unless TYPE.include?(type)
    raise InvalidLength.new("length should be between 1 and 26") unless (1..26).include?(length)

    self.privatekey = privatekey
    self.length = length
    self.type = type
  end

  def generate(tag, masterkey, length: self.length, type: self.type)
    tag = hash(privatekey, tag, 24) unless privatekey.nil?

    hash(tag, masterkey, length, type)
  end

  private

  def hash(data, key, length, type = :alphanumeric_and_special_chars)
    digest = OpenSSL::Digest.new('sha1')
    data_hash = Base64.strict_encode64(
      OpenSSL::HMAC.digest(digest, key, data)).sub(/=*\z/, '')

    sum = data_hash.chars.map(&:ord).inject(:+)

    if type == :numeric
      data_hash = convert_to_digits(data_hash, sum, length)
    else
      data_hash = inject_character(data_hash, 0, 4, sum, length, '0', 10)

      if type == :alphanumeric_and_special_chars
        data_hash = inject_character(data_hash, 1, 4, sum, length, '!', 15)
      end

      data_hash = inject_character(data_hash, 2, 4, sum, length, 'A', 26)
      data_hash = inject_character(data_hash, 3, 4, sum, length, 'a', 26)

      if type == :alphanumeric
        data_hash = remove_special_characters(data_hash, sum, length)
      end
    end

    data_hash.slice(0, length)
  end

  def convert_to_digits(input, seed, length)
    pivot = 0

    input.chars.map.with_index do |char, i|
      if char =~ /[[:digit:]]/
        res = char
      else
        res = ((seed + input[pivot].ord) % 10 + '0'.ord).chr
        pivot = i + 1
      end

      res
    end.join
  end

  def inject_character(input, offset, reserved, seed, length, c_start, c_num)
    pos0 = seed % length
    pos = (pos0 + offset) % length

    c_start = c_start.ord

    (0..length - reserved).each do |i|
      tmp = (pos0 + reserved + i) % length
      char = input[tmp].ord

      return input if char >= c_start && char < c_start + c_num
    end

    head = input[0..pos-1]
    inject = ((seed + input[pos].ord) % c_num) + c_start
    tail = input[pos+1..-1]

    head + inject.chr + tail
  end

  def remove_special_characters(input, seed, length)
    pivot = 0

    input.chars.map.with_index do |char, i|
      if char =~ /[[:alnum:]]/
        res = char
      else
        res = ((seed + input[pivot].ord) % 26 + 'A'.ord).chr
        pivot = i + 1
      end

      res
    end.join
  end
end
