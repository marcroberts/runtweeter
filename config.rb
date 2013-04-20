require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'yaml'
require 'time'
require 'open-uri'
CONFIG = YAML.load(IO.read("config.yml"))

require './runkeeper'

Geocoder.configure :lookup => :google