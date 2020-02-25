# frozen_string_literal: true

require_relative '../csv_parsing/csv_parser.rb'
require './csv_parsing/length_determinant.rb'

# Class to create lines for console output
class LinesBuilder < LengthDeterminant
  def max_length_hash
    define_max_length
  end

  def count_length_line
    chars_count = 0
    (0..max_length_hash.length - 1).each do |i|
      chars_count += max_length_hash[i]
    end
    chars_count
  end

  def create_first_line
    chars_count = count_length_line
    first_line = '+'.dup
    (1..(chars_count + max_length_hash.length - 1)).each do
      first_line.concat('-')
    end
    first_line.concat('+')
  end

  def create_last_line
    last_line = '+'.dup
    (0..max_length_hash.length - 1).each do |i|
      (1..max_length_hash[i]).each do
        last_line.concat('-')
      end
      last_line.concat('+')
    end
    last_line
  end
end
