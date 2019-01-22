#! usr/bin/env ruby
# frozen_string_literal: true

require 'bundler'
Bundler.require

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'app/val_doise_townhalls_scrapper'
require 'views/choose_url'
require 'views/done'
require 'app/save_file'

ValdOiseTownhallsScrapper.new.perform
