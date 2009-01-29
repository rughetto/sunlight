require 'rubygems'
require 'json'
require 'cgi'
require 'ym4r/google_maps/geocoding'
require 'net/http'
include Ym4r::GoogleMaps

require File.dirname(__FILE__) + '/sunlight/sunlight_object'
require File.dirname(__FILE__) + '/sunlight/district'
require File.dirname(__FILE__) + '/sunlight/legislator'