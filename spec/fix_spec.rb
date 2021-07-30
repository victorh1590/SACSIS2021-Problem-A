require 'fix'

describe Fix do
  let(:st_input) { 
    "8 8000\n"\
    "6 23486\n"\
    "1 87123878117\n"\
    "7 7777777477777\n"\
    "-1 -1\n"\
    "0 0\n"
  }

  let(:processed_st_input) {
    st_input.split(/\n+/)
  }

  let(:separated_st_input) {
    arr = processed_st_input.dup
    arr.map! { |element| element.split(" ") }
  }

  let(:negatives_removed) {
    [
      ["8", "8000"], 
      ["6", "23486"], 
      ["1", "87123878117"], 
      ["7", "7777777477777"], 
    ]
  }

  let(:result_array) {
    [0, 2348, 87238787, 4]
  }

  let(:printed_result) {
    "0\n"\
    "2348\n"\
    "87238787\n"\
    "4\n"
  }

  context "When trying to read the standard input with the read_input method" do
    before do
      # puts separated_st_input.to_s
      subject = Fix.new
      input = StringIO.new

      input.puts(st_input)
      input.rewind

      $stdin = input

      # Another possible way of doing this.
      # allow(STDIN).to receive(:gets) {st_input}
    end

    it "Should read the input correctly and return an"\
       " array where each element is a line from the input string." do
      expect(subject.read_input).to eq processed_st_input
      expect(subject.read_input).to be_instance_of(Array)
    end

    it "Should map a array of strings with strings structured like"\
       " text-space-text and return an array of arrays of string"\
       " => [[text, text], [text, text], ...] removing the space." do

      expect(subject.process_input(processed_st_input)).to eq separated_st_input
    end

    it "Remove element from the array result from the last text in case"\
    " element[0] of a element has a '-' character and also pop last element"\
    " => [0,0]." do
      expect(subject.remove_negative(separated_st_input)).to eq negatives_removed
    end

    it "Should receive the array from the previous test as input and"\
    " process each element, removing the element[0] string from element[1]"\
    " string and then store the value of each processed element[1] as"\
    " a integer in a new array of integers." do
      expect(subject.fix_and_return_array_of_int(negatives_removed)).to eq result_array 
    end

    it "Print the result array with each element in a new line." do
      expect { subject.print_result(result_array) }.to output(printed_result).to_stdout
    end

    it "Call all methods for processing the input in the correct sequence." do
      expect { subject.fix_this() }.to output(printed_result).to_stdout
    end

    after do
      $stdin = STDIN
    end
  end
end
