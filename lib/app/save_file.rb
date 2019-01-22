# frozen_string_literal: true

require 'google_drive'
require 'pry'

class SaveFile
  def self.save_as_JSON(input_hash)
    f = File.open(Dir.getwd + '/db/emails.json', 'w+')
    f.write(input_hash.to_json)
    f.close
    f
    puts
    puts 'Votre fichier JSON est accessibles dans le dossier db.'
  end

  def self.save_as_csv(input_hash)
    f = File.open(Dir.getwd + '/db/emails.csv', 'w+')
    f.write(input_hash.to_a.map { |c| c.join(',') }.join("\n"))
    f.close
    f
    puts
    puts 'Votre fichier CSV est accessibles dans le dossier db.'
  end

  def self.save_as_gsheet(input_hash)
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    # See this document to learn how to create config.json:
    # https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
    session = GoogleDrive::Session.from_config('config.json')

    # First worksheet of
    # https://docs.google.com/spreadsheets/d/1ovc5_bO7lbVWoO3M7TlsBU8QjhOdSiXgaJwhy6XRXUo/edit?usp=sharing
    worksheet = session.spreadsheet_by_key('1ovc5_bO7lbVWoO3M7TlsBU8QjhOdSiXgaJwhy6XRXUo').worksheets[0]

    # Changes content of cells.
    # Changes are not sent to the server until you call ws.save().
    worksheet[1, 1] = 'Nom de ville'
    worksheet[1, 2] = 'Email de mairie'
    row_index = 0
    input_hash.each do |town_name, townhall_email|
      worksheet[2 + row_index, 1] = town_name.to_s
      worksheet[2 + row_index, 2] = townhall_email
      row_index += 1
    end

    worksheet.save
    worksheet.reload

    puts
    puts 'Votre feuille Google Sheet est accessible sur ce lien :'
    puts 'https://docs.google.com/spreadsheets/d/1ovc5_bO7lbVWoO3M7TlsBU8QjhOdSiXgaJwhy6XRXUo/edit?usp=sharing'
  end
end
