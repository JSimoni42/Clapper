require "spec_helper"

RSpec.describe Clapper do
  it "does something useful" do
    expect(Clapper.clappy).to eq("Clap!!")
  end

  it "has a version number" do
    expect(Clapper::VERSION).to be nil
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
end
