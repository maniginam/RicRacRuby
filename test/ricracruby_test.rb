# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ricracruby'

# Test program coolness
class RicRacRubyTest < Minitest::Test
  def test_coolness_off_the_charts
    # skip
    assert_equal RicRacRuby.new.coolness, 11
  end
end
