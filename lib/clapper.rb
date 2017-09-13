require "clapper/version"
require "audio-playback"
require 'csv'

module Clapper
  def self.clappy
    return 'Clap!'
  end

  def self.compare(example_list)
    f = Clapper.openFile
    old_examples = f.readlines
    f.close
    p parsed_examples = Clapper.parse_examples(old_examples)
    will_clap = false
    f = CSV.open("tests.csv", "w")
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
    if !File.exist?("tests.csv")
      CSV.new(File.new("tests.csv", "w+"))
    else
      CSV.open("tests.csv", "r+")
    end
  end

  def self.parse_examples(old_examples)
    old_examples.reduce({}) do |acc, example_row|
      acc[example_row[0]] = example_row[1].to_sym
      acc
    end
  end

  def self.clap(will_clap)
    output = AudioPlayback::Device::Output.by_id(1)
    options = {
      :channels => [0,1],
      :latency => 1,
      :output_device => output,
      :duration => 5
    }
    if will_clap
      playback = AudioPlayback.play("audio/Clapping.wav", options)
      playback.block
    end
  end
end
