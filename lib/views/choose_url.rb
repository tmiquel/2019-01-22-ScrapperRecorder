#! usr/env/bin ruby
# frozen_string_literal: true

class ChooseUrl
  attr_accessor :url

  def initialize
    perform_intro_view
    confirm_url_view
    perform_launch_scrapper_view unless @url == 'exit'
  end

  def perform_intro_view
    puts
    puts '=' * 60
    puts ' ' * 5 + "LE SCRAPPER DES MAIRIES DU VAL D'OISE"
    puts '=' * 60
    puts
    puts 'Ce scrapper va scanner le site'
    puts "'http://annuaire-des-mairies.com/val-d-oise.html'"
    puts "afin d'en extraire un hash contenant pour chaque clé"
    puts "'nom de ville' une valeur 'email de la mairie'."
    puts
  end

  def confirm_url_view
    puts "Confirmez-vous que l'adresse du site n'a pas changé?"
    puts 'Si cette adresse est '
    puts 'http://annuaire-des-mairies.com/val-d-oise.html'
    puts "entrez oui, sinon n'importe quelle touche"
    print '> '
    answer = gets.chomp.to_s
    puts
    case answer.downcase
    when 'oui'
      puts 'Merci. Adresse inchangée'
      puts
    else
      url = change_url_view
      if url == 'reboot'
        perform_intro_view
        url = confirm_url_view
      end
    end
    @url = url || 'http://annuaire-des-mairies.com/val-d-oise.html'
  end

  def change_url_view
    puts
    puts 'Quelle est la nouvelle adresse? (changer de département par exemple)'
    print '> '
    url = gets.chomp.to_s
    puts
    puts "La nouvelle adresse est '#{url}'."
    puts
    unless url.include?('http://annuaire-des-mairies.com/')
      puts 'Cette adresse ne contient pas le préfixe http://annuaire-des-mairies.com/'
      puts 'Le scrapper ne marchera pas.'
      puts 'Voulez-vous relancer le scrapper?'
      print "(oui, sinon n'importe quelle touche) > "
      start_again = gets.chomp.to_s
      case start_again
      when 'oui'
        url = 'reboot'
      else
        url = 'exit'
        puts
        puts 'AU REVOIR'
        puts
      end
    end
    url
  end

  def perform_launch_scrapper_view
    puts
    puts '-' * 60
    puts
    puts ' ' * 5 + 'Scrapping en cours..'
    puts
    puts '-' * 60
  end
end
