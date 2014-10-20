require 'test_helper'

# Port of the tests from Twik Python version
class Twik::PythonTest < Minitest::Test
  PRIVATE_KEY = 'TFCY2AJI-NBPU-V01E-F7CP-PJIZNRKPF25W'
  MASTER_KEY = 'foobar'
  TAG = 'tag'

  VALUES = {
    alphanumeric_and_special_chars: {
      4 => 'm3/I',
      8 => 'mb/5AsJ9',
      12 => 'mb/5AsJ9Uon7',
      22 => 'mb15As*9Uon7ZzvcsXMjpV',
      26 => 'mb15AsJ9&on7ZzvcsXMjpVLTqQ',
    },
    alphanumeric: {
      4 => 'm31I',
      8 => 'mb15AsJ9',
      12 => 'mb15AsJ9Uon7',
      22 => 'mb15AsJ9Uon7ZzvcsXMjpV',
      26 => 'mb15AsJ9Uon7ZzvcsXMjpVLTqQ',
    },
    numeric: {
      4 => '4315',
      8 => '43154099',
      12 => '431540992657',
      22 => '4315409926570734032171',
      26 => '43154099265707340321711986',
    }
  }

  def setup
    @twik = Twik.new(PRIVATE_KEY)
  end

  VALUES.keys.each do |type|
    define_method(:"test_password_#{type}") do
      @twik.type = type

      VALUES[type].each do |length,value|
        assert_equal value, @twik.generate(TAG, MASTER_KEY, length: length)
      end
    end
  end

  def test_size
    (1..26).each do |length|
      assert_equal length, @twik.generate(TAG, MASTER_KEY, length: length).length
    end
  end
end
