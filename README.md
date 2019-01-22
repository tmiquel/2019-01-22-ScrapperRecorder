README
======

THP Marseille - Fichier de rendu pour le 2019/01/22

# Val d'Oise Scrapper (outputs in csv, json, Google Sheet)

Ce programme scrappe sur http://annuaire-des-mairies.com/val-d-oise.html les emails des mairies du Val d'Oise et retourne (choix de l'utilisateur) ces emails dans des fichiers JSON, CSV et/ou Google Sheet. Les fichiers JSON et CSV sont accessibles dans le dossier db.

## Getting Started

1. Clone or Download this folder
2. Optional - if you would like a Google Sheet output, set a config.json file in the root folder (instructions <a href="https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md">here</a>)
3. Run "ruby app.rb"

## Running the tests

No test.

## Folder Structure

app.rb - main file. Entry point for this programme. Initialise a new instance of the ValdOiseScrapper.

config.json - login for Google Sheet. <em>To be added by each user</em>

Gemfile : environment required (gems and ruby version)
Gemfile.lock

<strong>db</strong> - database folder

	- emails.json: output file in json
	
	- emails.csv : output file in csv
	

<strong>lib</strong> - lib folder

	<strong>app</strong> - all apps
	
		- save_file.rb :  SaveFile class saving your output in csv, json and Google Sheet
		
		- val_doise_townhalls_scrapper.rb : ValdOiseScrapper class scrapping the annuaires-des-mairies.com website
		
	<strong>views</strong> - All Front-End executions (printing on terminal)
	
		- choose_url.rb: ChooseUrl class printing an intro and a menu at the beginning of the programme
		
		- done.rb : Done class printing an outro and a menu to select which output file format you would like to choose

<strong>spec</strong> - Test folder. Empty.

## Versioning

No versioning 

## Authors

* **Thibaut Miquel** - *06 99 33 28 11* - Thibaut Miquel on Slack

## License

No license.

## Acknowledgments

Note : on a travaillé ensemble, mais chacun a customizé son code.
Ce rendu est le rendu de l'un d'entre nous.


