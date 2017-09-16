require "clapper/version"
# require "audio-playback"
require 'csv'

module Clapper
  def self.compare(example_list)
    f = Clapper.openFile
    old_examples = f.readlines
    f.close
    parsed_examples = Clapper.parse_examples(old_examples)
    will_clap = false
    f = CSV.open(Clapper.path_to_testfile, "w")
    example_list.each do |example|
      if parsed_examples[example.id] == nil && example.execution_result.status == :passed
        will_clap = true
      elsif parsed_examples[example.id] == :failed && example.execution_result.status == :passed
        will_clap = true
      end
      f << [example.id, example.execution_result.status]
    end
    f.close
    Clapper.clap(will_clap)
  end

  private

  def self.openFile
    if !File.exist?(Clapper.path_to_testfile)
      CSV.new(File.new(Clapper.path_to_testfile, "w+"))
    else
      CSV.open(Clapper.path_to_testfile, "r+")
    end
  end

  def self.parse_examples(old_examples)
    old_examples.reduce({}) do |acc, example_row|
      acc[example_row[0]] = example_row[1].to_sym
      acc
    end
  end

  def self.clap(will_clap)
    if will_clap
      `play #{Clapper.path_to_audio} trim 0 5`
    end
  end

  def self.path_to_audio
    File.join(File.dirname(__FILE__), '../assets/Clapping.wav')
  end

  def self.path_to_testfile
    File.join(File.dirname(__FILE__), '../assets/tests.csv')
  end
end
