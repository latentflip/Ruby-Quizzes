require '1-madlib'
require 'test/unit'
require 'pp'

class MadLibTest < Test::Unit::TestCase
  def test_no_interpolation
    madlib = Madlib::Game.new("hello, world!")
    madlib.tokenize
    assert_equal("hello, world!", madlib.to_s)
  end

  def test_tokenize
    madlib = Madlib::Game.new("hello ((name)), nice ((noun))")
    madlib.tokenize
    assert_equal([:name, :noun], madlib.tokens)
    assert_equal(["hello ", :name, ", nice ", :noun], madlib.tokenized_template)
  end

  def text_interpolate
    madlib = Madlib::Game.new("hello ((name)), nice ((noun))")
    madlib.tokenize
    madlib.values = {:name => 'Phil', :noun => 'hat'}
    assert_equal("hello Phil, nice hat", madlib.to_s)
  end
end

madlib = Madlib::Game.new("hello ((name)), nice ((noun))")
madlib.play
