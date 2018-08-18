# test_nanowrimo.rb
require 'minitest/autorun'
require 'nanowrimo'
require 'test_helper'

class NanowrimoTest < Minitest::Test

	def test_yield_block
		wc = nil
		Nanowrimo::Nanowrimo.new { |nano| wc = nano.summary('jezra') }
		assert_equal(wc[:user_wordcount], 5907)
	end

	def test_failures
		nano = Nanowrimo::Nanowrimo.new

		assert_raises RuntimeError do 
			nano.summary
		end

		assert_raises RuntimeError do 
			nano.set_wordcount(11111)
		end

		nano = Nanowrimo::Nanowrimo.new('jezra')

		assert_raises RuntimeError do 
			nano.set_wordcount(11111)
		end
	end
end