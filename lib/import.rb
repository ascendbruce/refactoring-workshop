require 'csv'

# 1. Create a class with same initialization arguments as BIGMETHOD
# 2. Copy & Paste the method's body in the new class, with no arguments
# 3. Replace original method with a call to the new class
# 4. Apply "Intention Revealing Method" to the new class. Woot!

class FormatterNew
  def initialize(file_name)
    @file_name = file_name
    @hash      = { '1' => {}, '2' => {} }
    @dates     = []
  end

  def perform
    load_values_from_csv
    turn_into_b_format
  end

  private

  def load_values_from_csv
    file = File.open @file_name, 'r:ISO-8859-1'
    CSV.parse(file, col_sep: ';').each do |row|
      next if row.empty? || row[0] =~ /^\/\//
      load_a_month(row)
    end
  end

  def load_a_month(row)
      @beginning_of_the_month = Date.parse(row[2])
      (13..43).each do |i|
        load_a_day(row, i)
      end
  end

  def load_a_day(row, i)
    measurement_date = @beginning_of_the_month + (i-13)

    # If NumDiasDeChuva is empty it means no data
    value  = row[7].nil? ? -99.9 : row[i]
    status = row[i + 31]
    hash_value = [value, status]

    @dates << measurement_date
    @hash[row[1]][measurement_date] = hash_value
  end

  def turn_into_b_format
    array_of_day = @dates.uniq.map { |date| format_for_day(date) }
    array_of_day.join("\n") + "\n"
  end

  def format_for_day(date)
    old_value = @hash['1'][date]
    new_value = @hash['2'][date]
    if only_bruto?(date)
      result = [date, old_value[0], old_value[1]]
    elsif only_consistido?(date)
      result = [date, new_value[0], new_value[1]]
    else # 'bruto' y 'consistido' (has new and old data)
      result = [date, new_value[0], old_value[1], old_value[0]]
    end
    result.join("\t")
  end

  def only_bruto?(date)
    !@hash['1'][date].nil? && @hash['2'][date].nil?
  end

  def only_consistido?(date)
    @hash['1'][date].nil? && !@hash['2'][date].nil?
  end

end

class Formatter
  # More code, methods, and stuff in this big class

  def row_per_day_format(file_name)
    # FIXME: 3 Replace Method with Method Object

    FormatterNew.new(file_name).perform
  end

  # More code, methods, and stuff in this big class
end
