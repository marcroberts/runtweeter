require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'yaml'
require 'time'
require 'open-uri'
require 'logger'
CONFIG = YAML.load(IO.read("config.yml"))

require './runkeeper'

DEBUG = true
LOG = Logger.new 'debug.log'
RECENCY = 600 # 10 mins

Geocoder.configure :lookup => :google