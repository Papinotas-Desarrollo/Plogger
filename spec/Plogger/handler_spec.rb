require "spec_helper"
require 'Plogger/config'
require 'Plogger/id_generator'

describe Plogger::Handler do
  before(:each) do
    @logger = double("A Logger", error: nil, warn: nil, info: nil, debug: nil)
  end
  describe 'handle_exception' do
    before(:each) do
      @handler = Plogger::Handler.new(Plogger::Config.new(@logger))
    end
    it 'calls the logger' do
      expect(@logger).to receive(:error).with(/A message --*/)
      @handler.handle_exception(double("Exception", message: 'A message'))
    end

    it 'returns the trace' do
      expect(@handler.handle_exception(double("Exception", message: 'A message'))).to be_a(String)
      expect(@handler.handle_exception(double("Exception", message: 'A message')).length).to eq Plogger::IdGenerator.id_length
    end
  end

  describe 'handle_error' do
    before(:each) do
      @handler = Plogger::Handler.new(Plogger::Config.new(@logger))
    end
    it 'calls the logger' do
      expect(@logger).to receive(:error).with(/A message --*/)
      @handler.handle_error('A message')
    end

    it 'returns the trace' do
      expect(@handler.handle_error('A message')).to be_a(String)
      expect(@handler.handle_error('A message').length).to eq Plogger::IdGenerator.id_length
    end
  end

  describe 'handle_warning' do
    before(:each) do
      @handler = Plogger::Handler.new(Plogger::Config.new(@logger))
    end
    it 'calls the logger' do
      expect(@logger).to receive(:warn).with(/A message --*/)
      @handler.handle_warning('A message')
    end

    it 'returns the trace' do
      expect(@handler.handle_warning('A message')).to be_a(String)
      expect(@handler.handle_warning('A message').length).to eq Plogger::IdGenerator.id_length
    end
  end

  describe 'handle_info' do
    before(:each) do
      @handler = Plogger::Handler.new(Plogger::Config.new(@logger))
    end
    it 'calls the logger' do
      expect(@logger).to receive(:info).with(/A message --*/)
      @handler.handle_info('A message')
    end

    it 'returns the trace' do
      expect(@handler.handle_info('A message')).to be_a(String)
      expect(@handler.handle_info('A message').length).to eq Plogger::IdGenerator.id_length
    end
  end

  describe 'handle_debug' do
    before(:each) do
      @handler = Plogger::Handler.new(Plogger::Config.new(@logger))
    end
    it 'calls the logger' do
      expect(@logger).to receive(:debug).with(/A message --*/)
      @handler.handle_debug('A message')
    end

    it 'returns the trace' do
      expect(@handler.handle_debug('A message')).to be_a(String)
      expect(@handler.handle_debug('A message').length).to eq Plogger::IdGenerator.id_length
    end
  end


  it 'handles module info correctly' do
    config = Plogger::Config.new(@logger)
    config.module = 'Module'
    @handler = Plogger::Handler.new(config)
    expect(@logger).to receive(:error).with(/ * module='Module'/)
    @handler.handle_error('A message')
  end

end
