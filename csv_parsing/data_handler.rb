# frozen_string_literal: true

require './csv_parsing/csv_parser.rb'
require './csv_parsing/lines_builder.rb'
require './csv_parsing/length_determinant.rb'

# Base Data class to delegate adding space realization
class DataHandler < LinesBuilder
  def change_format(index, value) # rubocop:disable Metrics/MethodLength
    index_types = create_hash_index_types
    case index_types[index]
    when INT_COLUMN
      IntDataHandler.new.add_space(index, value)
    when STRING_COLUMN
      StringDataHandler.new.add_space(index, value)
    when MONEY_COLUMN
      MoneyDataHandler.new.add_space(index, value)
    else
      ''
    end
  end

  def create_space(index, value)
    int_max_length = define_max_length[index]
    space = ''.dup
    (value.length..int_max_length - 1).each do
      space.concat(' ')
    end
    space
  end
end

class IntDataHandler < DataHandler
  def add_space(index, value)
    create_space(index, value).concat(value)
  end
end

class StringDataHandler < DataHandler
  def add_space(index, value)
    value.concat(create_space(index, value))
  end
end

class MoneyDataHandler < DataHandler
  def add_space(index, value)
    create_space(index, value).concat(value.gsub('.', ','))
  end
end
