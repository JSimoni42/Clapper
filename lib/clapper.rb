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
    i = 0
    while i+1 < old_examples.length
      parsed_examples[old_examples[i].chomp] = old_examples[i+1].chomp.to_sym
      i += 2
    end

    f = File.open("tests.txt", "w+")
    example_list.each do |example|
      if parsed_examples[example.id] == nil && example.execution_result.status == :passed
        p "CLAP!!!"
      elsif parsed_examples[example.id] == :failed && example.execution_result.status == :passed
        p "CLAP!!"
      else
        p "NO CLAP...."
      end
      f.write("#{example.id}\n")
      f.write("#{example.execution_result.status}\n")
    end
    f.close
  end
end
