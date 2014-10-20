require 'test_helper'

class TwikTest < Minitest::Test
  def setup
    @twik = Twik.new('TEST')
  end

  def test_that_generates_password
    @twik.length = 16

    assert_equal 'N4eCufjtnKRM+8dK', @twik.generate('test', 'test', type: :alphanumeric_and_special_chars)
    assert_equal 'N4eCufjtnKRMK8dK', @twik.generate('test', 'test', type: :alphanumeric)
    assert_equal '4483382261839821', @twik.generate('test', 'test', type: :numeric)
  end

  def test_that_length_is_correct
    assert_equal 1, @twik.generate('test', 'test', length: 1).length
    assert_equal 26, @twik.generate('test', 'test', length: 26).length
    assert_equal 8, @twik.generate('test', 'test', length: 8).length
  end

  def test_that_type_is_numeric
    assert_match(/\A[0-9]+\z/, @twik.generate('test', 'test', type: :numeric))
  end

  def test_that_type_is_alphanumeric
    assert_match(/\A[A-Za-z0-9]+\z/, @twik.generate('test', 'test', type: :alphanumeric))
  end

  def test_that_type_is_alphanumeric_and_special_chars
    refute_match(/\A[A-Za-z0-9]+\z/, @twik.generate('test', 'test', type: :alphanumeric_and_special_chars))
  end
end
