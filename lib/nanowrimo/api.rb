# api.rb
require 'net/http'
require 'digest/sha1'
require 'nori'

module Nanowrimo

	# Class that handles all the NaNoWriMo API transactions
	class API

		WORDCOUNTAPI_URL = 'https://nanowrimo.org/wordcount_api'
		WRITEAPI_URL = 'http://nanowrimo.org/api/wordcount'

		# Gets the wordcount of the user provided
		#
		# == Parameters:
		# A string of the user to obtain the wordcount
		#
		# == Returns:
		# A hash of the wordcount information
		def self.get_wordcount(user)
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wc/#{user}"))
			data = symbolize_keys(nori.parse(xml)['wc']) # TODO: What do if the user doesn't exist?
			convert_vals(data)
		end

		# Get the wordcount history of the user provided
		#
		# == Parameters:
		# A string of the user to obtain the history for
		#
		# == Returns:
		# A hash of the wordcount history information
		def self.get_wordcount_history(user)
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wchistory/#{user}"))
			data = symbolize_keys(nori.parse(xml)['wchistory'])
			data[:wordcounts] = data[:wordcounts]['wcentry']
			data[:wordcounts] = data[:wordcounts].map { |e| convert_vals(symbolize_keys(e)) }
			convert_vals(data)
		end

		# Gets the wordcount for the whole site
		def self.get_site_wordcount
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wcstatssummary"))
			data = symbolize_keys(nori.parse(xml)['wcstatssummary'])
			convert_vals(data)
		end

		# Get the wordcount history for the whole site
		def self.get_site_wordcount_history
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wcstats"))
			data = symbolize_keys(nori.parse(xml)['wcstats'])
			convert_vals(data)
		end

		# Gets the wordcount of the region provided
		#
		# == Parameters:
		# A string of the region to obtain the wordcount
		#
		# == Returns:
		# A hash of the wordcount information
		def self.get_regional_wordcount(region)
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wc/#{region}"))
			data = symbolize_keys(nori.parse(xml)['wcregion']) # TODO: What do if the region doesn't exist?
			convert_vals(data)
		end

		# Get the wordcount history of the region provided
		#
		# == Parameters:
		# A string of the region to obtain the history for
		#
		# == Returns:
		# A hash of the wordcount history information
		def self.get_regional_wordcount_history(region)
			xml = Net::HTTP.get(URI("#{WORDCOUNTAPI_URL}/wchistory/#{region}"))
			data = symbolize_keys(nori.parse(xml)['wchistory'])
			data[:wordcounts] = data[:wordcounts]['wcentry']
			data[:wordcounts] = data[:wordcounts].map { |e| convert_vals(symbolize_keys(e)) }
			convert_vals(data)
		end

		# Updates the wordcount of the user provided, assuming the secret matches properly
		#
		# == Parameters:
		# The secret key of the user (as a string,) the username of the user, and the new
		# wordcount
		#
		# == Returns:
		# true if successful
		def self.update_wordcount(secret, username, wordcount)
			hex = Digest::SHA1.hexdigest("#{secret}#{username}#{wordcount}")
			req = Net::HTTP::Put.new("/wordcount/#{hex}", initheader = { hash: hex, name: username, wordcount: wordcount.to_s})
			response = Net::HTTP.new('nanowrimo.org', 80).start { |http| http.request(req) }
			puts ">>> #{response}"
		end

		private

		NORI_INST = Nori.new

    def self.nori
    	return NORI_INST
    end

    def self.symbolize_keys(res)
    	return if res.nil?
    	res.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo }
		end

		# Converts all the possible numeric values in the hash provided
		def self.convert_vals(data)
			data.each do |k, v|
				next if !v || !v.is_a?(String)

				if /\A[0-9]+\z/.match(v)
					data[k] = v.to_i
				elsif /\A[0-9]+\.[0-9]+\z/.match(v)
					data[k] = v.to_f
				end
			end
		end
	end
end