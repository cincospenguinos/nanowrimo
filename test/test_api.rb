# test_api.rb
require 'minitest/autorun'
require 'nanowrimo'
require 'test_helper'

class ApiTest < Minitest::Test
	def test_get_wordcount
		wordcount = Nanowrimo::API.get_wordcount('jezra')
		assert(!wordcount.nil?, 'get_wordcount() returned nil.')
		assert_equal(wordcount[:user_wordcount], 5907)

		# No user of this username should exist
		wordcount = Nanowrimo::API.get_wordcount('0000011111222223345897894dasjgoidashgoqyueworqyuiqhuieqoighoashuidgbzuibnoqieogueyho')
		assert(wordcount[:error] == "user does not exist")
	end

	def test_get_wordcount_history
		history = Nanowrimo::API.get_wordcount_history('jezra')
		assert_equal(5907, history[:user_wordcount])
	end

	def test_get_site_wordcount
		wc = Nanowrimo::API.get_site_wordcount
		assert(!wc.nil?)
		assert(wc.keys.include?(:site_wordcount))
	end

	def test_get_site_wordcount_history
		wc = Nanowrimo::API.get_site_wordcount_history
		assert(!wc.nil?)
		assert(wc.keys.include?(:site_word_count))
	end
end