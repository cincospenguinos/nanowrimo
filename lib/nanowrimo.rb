require "nanowrimo/version"
require "nanowrimo/api"

module Nanowrimo

	# Class object to interact with the API
  class Nanowrimo

  	attr_accessor :username
  	attr_writer :secret

  	# Initializer. 
  	#
  	# == Parameters:
  	# Username and secret API key of the person to modify wordcount for.
  	def initialize(username=nil, secret=nil)
  		@username = username
  		@secret = secret
  		yield self if block_given?
  	end

  	# Sets the wordcount of the current user to the value provided.
  	#
  	# == Parameters:
  	# The new wordcount value as either an integer or string.
  	#
  	# == Returns:
  	# true if successful
  	def set_wordcount(value)
  		value = value.to_s if value.is_a?(Integer)
  		raise RuntimeError, "wordcount value must be a valid number!" unless /\A\d+\z/.match(value)
  		raise RuntimeError, "user not set!" if @username.nil?
  		raise RuntimeError, "secret not set!" if @secret.nil?

  		API.update_wordcount(@secret, @username, value)
  	end

  	# Get the summary of some user, or the current user if the parameter provided is nil.
  	#
  	# == Parameters:
  	# Username of the person to look up, or nil to look up the current user's summary.
  	#
  	# == Returns:
  	# Summary hash of the current user's stats, or error hash if user does not exist.
  	def summary(user=nil)
  		raise RuntimeError, 'user not set!' if user.nil? && @username.nil?
  		user = @username if user.nil?

  		API.get_wordcount(user)
  	end

  	# Get the summary of the region provided.
  	#
  	# == Parameters:
  	# Regions to look up
  	#
  	# == Returns:
  	# Hash containing summary, or error hash if region does not exist.
  	def summary_region(region)
  		API.get_regional_wordcount(region)
  	end

  	# Get the summary for the entire site.
  	#
  	# == Returns:
  	# Hash containing summary for the site's stats.
  	def summary_site
  		API.get_site_wordcount
  	end

  	# Get the history of some user, or the current user if the parameter provided is nil.
  	#
  	# == Parameters:
  	# Username of the person to look up, or nil to look up the current user's history.
  	#
  	# == Returns:
  	# Summary hash of the current user's stats, or error hash if user does not exist.
  	def history(user=nil)
  		raise RuntimeError, 'user not set!' if user.nil? && @username.nil?
  		user ||= @username

  		API.get_wordcount_history(user)
  	end

		# Get the history of the region provided.
  	#
  	# == Parameters:
  	# Regions to look up
  	#
  	# == Returns:
  	# Hash containing history, or error hash if region does not exist.
  	def history_region(region)
  		API.get_regional_wordcount_history(region)
  	end

  	# Get the history for the entire site.
  	#
  	# == Returns:
  	# Hash containing history for the site's stats.
  	def history_site
  		API.get_site_wordcount_history
  	end
  end
end
