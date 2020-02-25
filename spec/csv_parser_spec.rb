# frozen_string_literal: true

require_relative '../csv_parsing/csv_parser'
require_relative '../csv_parsing/data_handler'
require_relative '../csv_parsing/length_determinant'
require_relative '../csv_parsing/lines_builder'
require_relative '../csv_parsing/display'

describe 'release logic' do
  ENV['CSV_FILE_PATH'] = './spec/test_spec.csv'
  it 'check length determinant' do
    length_det = LengthDeterminant.new
    expect(length_det.create_hash_index_types).to eq({ 0 => 'int', 1 => 'string', 2 => 'money' })
    expect(length_det.define_max_length).to eq({ 0 => 2, 1 => 4, 2 => 8 })
  end
  it 'check lines building' do
    length_builder = LinesBuilder.new
    expect(length_builder.count_length_line).to eq(14)
    expect(length_builder.create_first_line).to eq('+----------------+')
    expect(length_builder.create_last_line).to eq('+--+----+--------+')
  end
  it 'check adding space' do
    data_handler = DataHandler.new
    expect(data_handler.change_format(0, '1')).to eq(' 1')
    expect(data_handler.change_format(1, 'aa'.dup)).to eq('aa  ')
    expect(data_handler.change_format(2, '10.00')).to eq('   10,00')
  end
  it 'check concat string' do
    display = Display.new
    expect(display.get_index_string_type(3)).to eq(1)
    expect(display.concat_format_string('|'.dup, 0, '3')).to eq('| 3|')
  end
end
