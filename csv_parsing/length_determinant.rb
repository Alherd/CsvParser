# frozen_string_literal: true

require './csv_parsing/csv_parser.rb'

# Class to define max length of array values
class LengthDeterminant < CsvParser
  def create_hash_index_types
    column_types_array = data_from_csv[0][0].split(';')
    hash_index_types = {}
    (0..column_types_array.length - 1).each do |i|
      hash_index_types[i] = column_types_array[i]
    end
    hash_index_types
  end

  def define_max_length
    hash_max_length = {}
    index_types = create_hash_index_types
    (0..index_types.length - 1).each do |i|
      hash_max_length.merge!(i => 0)
    end
    iterate_csv_array(hash_max_length, index_types)
  end

  def iterate_csv_array(hash_max_length, index_types)
    data_csv_without_types_columns = data_from_csv.drop(1)
    data_csv_without_types_columns.each do |row|
      current_row_array = row[0].split(';')
      (0..current_row_array.length - 1).each do |index_value|
        define_max_length_value(hash_max_length, current_row_array, index_types, index_value)
      end
    end
    hash_max_length
  end

  def define_max_length_value(hash_max_length, current_row_array, index_types, index)
    if index_types[index] == STRING_COLUMN
      string_list = current_row_array[index].split(' ')
      string_list.each do |word|
        hash_max_length[index] = word.length if hash_max_length[index] < word.length
      end
    elsif hash_max_length[index] < current_row_array[index].length
      hash_max_length[index] = current_row_array[index].length
    end
  end
end
