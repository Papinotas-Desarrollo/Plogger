require "spec_helper"
require 'Plogger/id_generator'

describe Plogger do
  it "has a version number" do
    expect(Plogger::VERSION).not_to be nil
  end

  describe 'configure' do
    it 'can be configured' do
      logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = logger
      end
      expect(logger).to receive(:error).with('A message')
      Plogger.config.logger.error('A message')
    end
  end

  describe 'exception' do
    before(:each) do
      @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = @logger
      end
    end
    it 'calls the handler' do
      expect(@logger).to receive(:error).with(/A message --*/)
      Plogger.exception(double("Exception", message: 'A message'))
    end

    it 'returns the trace' do
      expect(Plogger.exception(double("Exception", message: 'A message'))).to be_a(String)
      expect(Plogger.exception(double("Exception", message: 'A message')).length).to eq(Plogger::IdGenerator.id_length)
    end
  end

  describe 'error' do
    before(:each) do
      @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = @logger
      end
    end
    it 'calls the handler' do
      expect(@logger).to receive(:error).with(/A message --*/)
      Plogger.error('A message')
    end

    it 'returns the trace' do
      expect(Plogger.error('A message')).to be_a(String)
      expect(Plogger.error('A message').length).to eq(Plogger::IdGenerator.id_length)
    end
  end

  describe 'warn' do
    before(:each) do
      @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = @logger
      end
    end
    it 'calls the handler' do
      expect(@logger).to receive(:warn).with(/A message --*/)
      Plogger.warn('A message')
    end

    it 'returns the trace' do
      expect(Plogger.warn('A message')).to be_a(String)
      expect(Plogger.warn('A message').length).to eq(Plogger::IdGenerator.id_length)
    end
  end

  describe 'info' do
    before(:each) do
      @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = @logger
      end
    end
    it 'calls the handler' do
      expect(@logger).to receive(:info).with(/A message --*/)
      Plogger.info('A message')
    end

    it 'returns the trace' do
      expect(Plogger.info('A message')).to be_a(String)
      expect(Plogger.info('A message').length).to eq(Plogger::IdGenerator.id_length)
    end
  end

  describe 'debug' do
    before(:each) do
      @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
      Plogger.configure do |config|
        config.logger = @logger
      end
    end
    it 'calls the handler' do
      expect(@logger).to receive(:debug).with(/A message --*/)
      Plogger.debug('A message')
    end

    it 'returns the trace' do
      expect(Plogger.debug('A message')).to be_a(String)
      expect(Plogger.debug('A message').length).to eq(Plogger::IdGenerator.id_length)
    end
  end

end
