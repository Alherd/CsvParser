# frozen_string_literal: true

require './csv_parser.rb'

# Base Data class to delegate adding space realization
class DataHandler < LinesBuilder
  INT_COLUMN = 'int'
  STRING_COLUMN = 'string'
  MONEY_COLUMN = 'money'

  def change_format(index, value)
    index_types = get_hash_index_types
    case index_types[index]
    when 'int'
      show_string = IntDataHandler.new.add_space(index, value)
    when 'string'
      show_string = StringDataHandler.new.add_space(index, value)
    when 'money'
      show_string = MoneyDataHandler.new.add_space(index, value)
    else
      show_string = ''
    end
    show_string
  end
end

class IntDataHandler < DataHandler
  def add_space(index, value)
    int_max_length = define_max_length[index]
    space = ''.dup
    (value.length..int_max_length - 1).each do
      space.concat(' ')
    end
    space.concat(value)
  end
end

class StringDataHandler < DataHandler
  def add_space(index, value)
    int_max_length = define_max_length[index]
    space = ''.dup
    (value.length..int_max_length - 1).each do
      space.concat(' ')
    end
    value.concat(space)
  end
end

class MoneyDataHandler < DataHandler
  def add_space(index, value)
    int_max_length = define_max_length[index]
    space = ''.dup
    (value.length..int_max_length - 1).each do
      space.concat(' ')
    end
    space.concat(replace_dot(value))
  end

  def replace_dot(value)
    value.gsub('.', ',')
  end
end

class Shower < DataHandler
  def show
    data_csv_without_types_columns = data_from_csv.drop(1)
    index_string_type = get_index_string_type(data_csv_without_types_columns[0][0].split(';').length)
    puts get_first_line
    data_csv_without_types_columns.each do |row|
      current_row_array = row[0].split(';')
      string_puts = '|'.dup
      (0..current_row_array.length - 1).each do |i|
        if index_string_type != -1
          if i == index_string_type
            string_array = current_row_array[i].split(' ')
            string_puts.concat(change_format(i, string_array[0])).concat('|')
          else
            string_puts.concat(change_format(i, current_row_array[i])).concat('|')
          end
        else
          string_puts.concat(change_format(i, current_row_array[i])).concat('|')
        end
        if index_string_type != -1 && i == current_row_array.length - 1
          string_array = current_row_array[index_string_type].split(' ').drop(1)
          string_array.each do |j|
            string_puts.concat("\n|")
            (0..i).each do |k|
              if k == index_string_type
                string_puts.concat(change_format(k, j)).concat('|')
              else
                string_puts.concat(change_format(k, '')).concat('|')
              end
            end
          end
        end
      end
      puts string_puts
      puts get_last_line
    end
  end

  def get_index_string_type(length_current_array)
    index_string = -1
    (0..length_current_array).each do |i|
      index_string = i if get_hash_index_types[i] == 'string'
    end
    index_string
  end
end
