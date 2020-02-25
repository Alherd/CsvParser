require './csv_parsing/display.rb'
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load
Display.new.show
