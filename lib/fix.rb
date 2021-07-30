class Fix
  def read_input()
    arr = []
    while line = gets
      arr.push(line.gsub(/\n+/, ""))
      break if line == "0 0\n"
    end
    return arr;
  end

  def process_input(input)
    arr = input.dup
    arr.map! { |element| element.split(" ") }
  end

  def remove_negative(input)
    arr = input.dup
    arr.select! { |element| not /-/.match?(element[0]) }.pop
    return arr
  end

  def fix_and_return_array_of_int(input)
    arr, result = input.dup, []
    arr.each { |element|
      result.push(element[1].gsub(element[0], "").to_i)
    }
    return result
  end

  def print_result(result)
    result.each { |element| puts element }
  end

  def fix_this()
    input = self.read_input
    input = process_input(input)
    input = remove_negative(input)
    result = fix_and_return_array_of_int(input)
    print_result(result)
  end
end