# frozen_string_literal: true

require 'CSV'
require 'dotenv'

# Base class to parse data to array from csv
class CsvParser
  INT_COLUMN = 'int'
  STRING_COLUMN = 'string'
  MONEY_COLUMN = 'money'

  attr_reader :data_from_csv

  def initialize
    @data_from_csv = CSV.read(ENV['CSV_FILE_PATH'])
  end
end
