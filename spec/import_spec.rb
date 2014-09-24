require_relative "../lib/import.rb"

RSpec.describe Formatter do
  def path(file_name)
    File.expand_path File.join(File.dirname(__FILE__), file_name)
  end

  it "is same to output file" do
    output = Formatter.new.row_per_day_format path('../lib/input.csv')
    expect(output).to eq File.read(path('../lib/output.csv'))
  end
end
