require "clapper/version"

module Clapper
  def self.clap
    return 'Clap!'
  end

  def self.compare(example_list)
    if !File.exist?("tests.txt")
      f = File.new("tests.txt", "w+")
    else
      f = File.open("tests.txt", "r+")
    end
    old_examples = f.readlines
    f.close
    parsed_examples = {}
    p old_examples
    i = 0
    while i+1 < old_examples.length
      parsed_examples[old_examples[i].chomp] = old_examples[i+1].chomp.to_sym
      i += 2
    end

    p "*" * 80
    p parsed_examples

    example_list.each do |example|
      p "Example id: #{example.id}"
      p "Example status: #{example.execution_result.status}"
      if parsed_examples[example.id] == nil && example.execution_result.status == :passed
        p "Example didn't exist in tests.txt, and we passed this test!"
        p "CLAP!!!"
      elsif parsed_examples[example.id] == :failed && example.execution_result.status == :passed
        p "We previously failed this test, and now we passed it!"
        p "CLAP!!"
      else
        p "NO CLAP...."
      end
    end


    f = File.open("tests.txt", "w+")
    example_list.each do |example|
      f.write("#{example.id}\n")
      f.write("#{example.execution_result.status}\n")
    end

    f.close
  end
end
