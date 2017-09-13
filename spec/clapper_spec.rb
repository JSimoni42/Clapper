require "spec_helper"

RSpec.describe Clapper do
  it "has a version number" do
    expect(Clapper::VERSION).to_not be nil
  end

  describe 'Clapper.openFile' do
    it "creates a new file if tests.csv doesn't exist" do
      if File.exist?("tests.csv")
        `rm tests.csv`
      end
      Clapper.openFile
      expect(File.exist?("tests.csv")).to be true
    end
  end

  describe 'Clapper.parse_examples' do
    let (:examples) {[["ex_id_1", "status_1"], ["ex_id_2", "status_2"], ["ex_id_3", "status_3"]]}
    let (:parsed) { Clapper.parse_examples(examples) }

    it 'converts an array of arrays into a hash' do
      expect(parsed.is_a?(Hash)).to be true
    end
    it 'leaves keys as strings' do
      expect(parsed.keys.sample.is_a?(String)).to be true
    end
    it 'converts values to symbols' do
      expect(parsed.values.sample.is_a?(Symbol)).to be true
    end
  end
end
