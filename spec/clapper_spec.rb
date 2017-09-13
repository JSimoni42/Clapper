require "spec_helper"

RSpec.describe Clapper do
  it "does something useful" do
    expect(Clapper.clappy).to eq("Clap!!")
  end

  it "has a version number" do
    expect(Clapper::VERSION).to be nil
  end
end
