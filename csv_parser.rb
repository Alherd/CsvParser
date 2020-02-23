require 'CSV'

class CsvParser
  CSV_FILE_PATH = './test.csv'
  attr_reader :data_from_csv

  def initialize
    @data_from_csv = CSV.read(CSV_FILE_PATH)
  end
end

class LengthDeterminant < CsvParser
  def get_hash_index_types
    column_types_array = data_from_csv[0][0].split(';')
    hash_index_types = Hash.new
    (0..column_types_array.length - 1).each do |i|
      hash_index_types[i] = column_types_array[i]
    end
    hash_index_types
  end

  def define_max_length
    hash_max_length = Hash.new
    index_types = get_hash_index_types
    (0..index_types.length - 1).each do |i|
      hash_max_length.merge!(i => 0)
    end

    data_csv_without_types_columns = data_from_csv.drop(1)
    data_csv_without_types_columns.each do |i|
      current_row_array = i[0].split(';')
      (0..current_row_array.length - 1).each do |j|
        if index_types[j] == 'string'
          string_list = current_row_array[j].split(' ')
          string_list.each do |word|
            hash_max_length[j] = word.length if hash_max_length[j] < word.length
          end
        else
          hash_max_length[j] = current_row_array[j].length if hash_max_length[j] < current_row_array[j].length
        end
      end
    end
    hash_max_length
  end
end

class LinesBuilder < LengthDeterminant
  attr_reader :last_line

  def max_length_hash
    define_max_length
  end

  def count_length_line
    chars_count = 0
    (0..max_length_hash.length - 1).each do |i|
      chars_count = chars_count + max_length_hash[i]
    end
    chars_count
  end

  def get_first_line
    chars_count = count_length_line
    first_line = '+'
    (1..(chars_count + max_length_hash.length - 1)).each do
      first_line.concat('-')
    end
    first_line.concat('+')
  end

  def get_last_line
    last_line = '+'
    (0..max_length_hash.length - 1).each do |i|
      (1..max_length_hash[i]).each do
        last_line.concat('-')
      end
      last_line.concat('+')
    end
    last_line
  end
end
