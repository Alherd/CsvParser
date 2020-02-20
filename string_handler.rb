require 'CSV'

class StringHandler

  COLUMN_NUMBER_INDEX = 0
  COLUMN_STRING_INDEX = 1
  COLUMN_MONEY_INDEX = 2

  def read_csv
    csv_read_result = CSV.read("/Users/alherd/Desktop/script/test.csv")

    puts '+-----------------+'
    (1..csv_read_result.length - 1).each do |i|
      convert_string(csv_read_result[i][0], '+--+----+---------+'.split('+').drop(1))
    end
  end

  def convert_string(str, array_size_columns)
    array_all_columns = str.split(';')
    array_string_column = array_all_columns[COLUMN_STRING_INDEX].split(' ')
    puts "|#{align_table(array_all_columns[COLUMN_NUMBER_INDEX], COLUMN_NUMBER_INDEX, array_size_columns)}|"\
      "#{align_table(array_string_column[0], COLUMN_STRING_INDEX, array_size_columns)}|" \
      "#{align_table(array_all_columns[COLUMN_MONEY_INDEX].gsub('.', ','), COLUMN_MONEY_INDEX, array_size_columns)}|"
    (1..array_string_column.length - 1).each do |i|
      puts "|#{align_table('', COLUMN_NUMBER_INDEX, array_size_columns)}|"\
        "#{align_table(array_string_column[i], COLUMN_STRING_INDEX, array_size_columns)}|"\
        "#{align_table('', COLUMN_MONEY_INDEX, array_size_columns)}|"
    end
    puts '+--+----+---------+'
  end

  def align_table(param, index, split_array)
    while param.length < split_array[index].length
      if index == COLUMN_STRING_INDEX
        param = param.concat(' ')
      else
        param = ' '.concat(param)
      end
    end
    param
  end

end