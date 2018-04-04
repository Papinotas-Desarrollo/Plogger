require "spec_helper"

describe Plogger::Formatter do
  it "generates a message with the correct format" do
    result = Plogger::Formatter.format("A message", 'a1234', user_id: 1, account_id: 1, category: 'A Category')
    expect(result).to eq("A message -- category='A Category' user_id=1 account_id=1 trace=a1234")
  end

  it "generates a message with the correct format when null values are submitted" do
    result = Plogger::Formatter.format("A message", 'a1234')
    expect(result).to eq("A message -- category='' user_id=null account_id=null trace=a1234")
  end

  it "generates a message with the correct format when extra_info is submitted" do
    result = Plogger::Formatter.format("A message", 'a1234', extra_info: {module: 'Communication'})
    expect(result).to eq("A message -- category='' user_id=null account_id=null trace=a1234 module='Communication'")
  end
end
