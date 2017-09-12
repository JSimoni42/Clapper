require "clapper/version"
require "audio-playback"

module Clapper
  def self.clap
    return 'Clap!'
  end

  def self.compare(example_list)
    # output = AudioPlayback::Device::Output.gets
    output = AudioPlayback::Device::Output.by_id(1)
    # p "*" * 100
    # p output
    options = {
      :channels => [0,1],
      :latency => 1,
      :output_device => output,
      :duration => 5
    }

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
    will_clap = false
    f = File.open("tests.txt", "w+")
    example_list.each do |example|
      if parsed_examples[example.id] == nil && example.execution_result.status == :passed
        will_clap = true
      elsif parsed_examples[example.id] == :failed && example.execution_result.status == :passed
        will_clap = true
      end
      f.write("#{example.id}\n")
      f.write("#{example.execution_result.status}\n")
    end
    f.close

    if will_clap
      playback = AudioPlayback.play("audio/Clapping.wav", options)
      playback.block
    end
  end
end
