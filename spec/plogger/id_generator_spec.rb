require "spec_helper"

describe Plogger::IdGenerator do
  it "generates different ids each time" do
    id1 = Plogger::IdGenerator.generate
    id2 = Plogger::IdGenerator.generate
    expect(id1).not_to eq(id2)
  end

end
