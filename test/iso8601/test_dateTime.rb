require "test/unit"
require "iso8601"


class TestDateTime < Test::Unit::TestCase
  def test_patterns
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("2") }
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("20") } # YY pattern will be correct
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("201") }
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("2010-") }
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("2010-0") }
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("2010-0-09") }
    assert_raise(ISO8601::Errors::UnknownPattern) { ISO8601::DateTime.new("2010-1-09") }

    assert_raise(RangeError) { ISO8601::DateTime.new("2010-01-32") }
    assert_raise(RangeError) { ISO8601::DateTime.new("2010-02-31") }
    
    assert_nothing_raised() { ISO8601::DateTime.new("2010") }
    assert_nothing_raised() { ISO8601::DateTime.new("2010-05") }
    assert_nothing_raised() { ISO8601::DateTime.new("2010-05-09") }
  end
  
  def test_atom_methods
    assert_equal(2010, ISO8601::DateTime.new("2010-05-09").year)
    assert_equal(5, ISO8601::DateTime.new("2010-05-09").month)
    assert_equal(9, ISO8601::DateTime.new("2010-05-09").day)
  end
  
  def test_to_time
    assert_instance_of(Time, ISO8601::DateTime.new("2010-05-09").to_time)
  end
end