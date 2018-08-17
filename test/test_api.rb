# test_api.rb
require 'minitest/autorun'
require 'nanowrimo'

class ApiTest < Minitest::Test
	def test_get_wordcount
		wordcount = Nanowrimo::API.get_wordcount('jezra')
		assert(!wordcount.nil?, 'get_wordcount() returned nil.')
		assert_equal(wordcount[:user_wordcount], 5907)
	end

	def test_get_wordcount_history
		history = Nanowrimo::API.get_wordcount_history('jezra')
		assert_equal(history[:user_wordcount], 5907)
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