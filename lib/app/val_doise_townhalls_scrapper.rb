#! usr/env/bin ruby
# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require_relative '../views/choose_url'
require_relative '../views/done'

class ValdOiseTownhallsScrapper
  attr_accessor :scrapped_url, :scrapped_townhalls_hash

  def initialize(
    scrapped_url_string =
    omitted = 'http://annuaire-des-mairies.com/val-d-oise.html'
  )
    @scrapped_url = omitted ? ChooseUrl.new.url : scrapped_url_string
    @scrapped_townhalls_hash = {}
  end

  def perform
    unless @scrapped_url == 'exit'
      @scrapped_townhalls_hash = get_townhalls_name_email_hash
      output = Done.new(@scrapped_townhalls_hash, @scrapped_url)
      output.perform_outro
    end
  end

  def get_townhall_name_email(town_url_string)
    townhall_email_xpath_string = '/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'

    townhall_name_xpath_string = '//a[@class="lientxt4"]'

    page = Nokogiri::HTML(open(town_url_string))

    town_email = page.css(townhall_email_xpath_string)
    town_email_string = (town_email.text.empty? ? 'Adresse non renseignée' : town_email.text)
    town_name_county = page.css(townhall_name_xpath_string)

    [town_name_county[0].text, town_email_string]
  end

  def get_townhall_urls(val_doise_url_string)
    val_doise_towns_url_array = []
    url_prefix_string = 'http://annuaire-des-mairies.com/'
    page = Nokogiri::HTML(open(val_doise_url_string))
    townhall_names_xpath_string = '//a[@class="lientxt"]'
    towns_urls = page.css(townhall_names_xpath_string)
    towns_urls.each do |town_url|
      val_doise_towns_url_array <<
        url_prefix_string + town_url['href'].to_s[2..-1]
    end

    val_doise_towns_url_array
  end

  def get_townhalls_name_email_hash
    val_doise_towns_url_array = get_townhall_urls(@scrapped_url)

    name_email_townhall_hash = {}

    val_doise_towns_url_array.each do |town_url|
      town_name_string, town_email_string = get_townhall_name_email(town_url)
      name_email_townhall_hash[town_name_string.to_sym] = town_email_string
    end

    name_email_townhall_hash
  end

  def save_as_JSON; end
end
