require "spec_helper"

describe Plogger::Formatter do
  it "generates a message with the correct format" do
    result = Plogger::Formatter.format("A message", 'a1234', user_id: 1, account_id: 1, category: 'A Category')
    expect(result).to eq("A message -- trace='a1234' log_provider='plogger' type='system' category='A Category' user_id=1 account_id=1")
  end

  it "generates a message with the correct format when null values are submitted" do
    result = Plogger::Formatter.format("A message", 'a1234')
    expect(result).to eq("A message -- trace='a1234' log_provider='plogger' type='system' category=''")
  end

  it "generates a message with the correct format when extra_info is submitted" do
    result = Plogger::Formatter.format("A message", 'a1234', extra_info: {module: 'Communication'})
    expect(result).to eq("A message -- trace='a1234' log_provider='plogger' type='system' category='' module='Communication'")
  end
end
