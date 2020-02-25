# frozen_string_literal: true

require './csv_parsing/data_handler.rb'
require './csv_parsing/lines_builder.rb'
require './csv_parsing/length_determinant.rb'

# Class to show console table output
class Display < DataHandler
  def show
    data_csv_without_types_columns = data_from_csv.drop(1)
    index_string_type = get_index_string_type(data_csv_without_types_columns[0][0].split(';').length)
    puts create_first_line
    data_csv_without_types_columns.each do |row|
      handle_row_array(row, index_string_type)
    end
  end

  def handle_row_array(row, index_string_type)
    current_row_array = row[0].split(';')
    string_puts = '|'.dup
    (0..current_row_array.length - 1).each do |i|
      split_current_row(current_row_array, index_string_type, i, string_puts)
      add_remaining_words(index_string_type, current_row_array, i, string_puts)
    end
    puts string_puts
    puts create_last_line
  end

  def split_current_row(current_row_array, index_string_type, index, string_puts)
    if index_string_type != -1
      if index == index_string_type
        string_array = current_row_array[index].split(' ')
        concat_format_string(string_puts, index, string_array[0])
      else
        concat_format_string(string_puts, index, current_row_array[index])
      end
    else
      concat_format_string(string_puts, index, current_row_array[index])
    end
  end

  def add_remaining_words(index_string_type, current_row_array, index, string_puts)
    return unless index_string_type != -1 && index == current_row_array.length - 1

    string_array = current_row_array[index_string_type].split(' ').drop(1)
    string_array.each do |word|
      string_puts.concat("\n|")
      handle_show_word(index, word, index_string_type, string_puts)
    end
  end

  def concat_format_string(string_puts, index_row_array, value)
    string_puts.concat(change_format(index_row_array, value)).concat('|')
  end

  def handle_show_word(index, word, index_string_type, string_puts)
    (0..index).each do |index_row_array|
      if index_row_array == index_string_type
        concat_format_string(string_puts, index_row_array, word)
      else
        concat_format_string(string_puts, index_row_array, '')
      end
    end
  end

  def get_index_string_type(length_current_array)
    index_string = -1
    (0..length_current_array).each do |i|
      index_string = i if create_hash_index_types[i] == 'string'
    end
    index_string
  end
end
