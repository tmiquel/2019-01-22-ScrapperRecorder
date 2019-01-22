#! usr/env/bin ruby
# frozen_string_literal: true

require_relative '../app/save_file'

class Done
  attr_accessor :scrapped_townhalls_hash

  def initialize(scrapped_townhalls_hash, scrapped_url)
    @scrapped_townhalls_hash = scrapped_townhalls_hash
    @scrapped_url = scrapped_url
  end

  def perform_outro
    puts
    puts '=' * 60
    puts ' ' * 5 + 'RESULTATS '
    puts '=' * 60
    puts
    puts 'Ce scrapper a scanné le site'
    puts @scrapped_url.to_s
    puts "afin d'en extraire un hash contenant pour chaque clé"
    puts "'nom de ville' une valeur 'email de la mairie'"
    puts
    puts 'Ces villes et emails sont les suivants :'
    print_hash
    puts
    puts 'Fin du scrapping'
    puts
    do_csv_output, do_gsheet_output, do_json_output = choose_output_format
    SaveFile.save_as_JSON(@scrapped_townhalls_hash) if do_json_output
    SaveFile.save_as_gsheet(@scrapped_townhalls_hash) if do_gsheet_output
    SaveFile.save_as_csv(@scrapped_townhalls_hash) if do_csv_output
    puts
    puts 'FIN'
    puts
  end

  def choose_output_format
    puts "Est-ce que vous voulez sauvegarder \
ces données dans un Google Sheet, un fichier JSON, et/ou un fichier CSV?"
    print '(csv : oui/autre touche)> '
    do_csv_output = (gets.chomp == 'oui')
    print '(Google Sheet : oui/autre touche)> '
    do_gsheet_output = (gets.chomp == 'oui')
    print '(JSON : oui/autre touche)> '
    do_json_output = (gets.chomp == 'oui')
    puts
    puts 'Merci.'
    puts
    puts 'Vous avez choisi une sortie ' + (do_csv_output ? 'csv ' : '') +
         (do_gsheet_output ? 'Google sheet ' : '') +
         (do_json_output ? 'JSON.' : '')
    [do_csv_output, do_gsheet_output, do_json_output]
  end

  def print_hash
    puts
    @scrapped_townhalls_hash.each do |town_name, town_email|
      puts "#{town_name} : #{town_email}"
      puts '-' * 60
    end
  end
end
