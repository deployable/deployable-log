require 'spec_helper'

describe Deployable::Log do


  describe 'simple' do

    it 'has a version number' do
      expect(Deployable::Log::VERSION).not_to be nil
    end

    before :each do
      @io  = StringIO.new
      @log = Deployable::Log.create @io
    end

    it 'trace' do
      @log.level = Deployable::Logger::TRACE
      @log.trace 'testt'
      expect( @io.string ).to  end_with ": testt\n"
    end

    it 'debug' do
      @log.level = Deployable::Logger::DEBUG
      @log.debug 'testd'
      expect( @io.string ).to  end_with ": testd\n"
    end
    
    it 'info' do
      @log.level = Deployable::Logger::INFO
      @log.info 'testi'
      expect( @io.string ).to  end_with ": testi\n"
    end

    it 'warn' do
      @log.level = Deployable::Logger::WARN
      @log.warn 'testw'
      expect( @io.string ).to  end_with ": testw\n"
    end

    it 'error' do
      @log.level = Deployable::Logger::ERROR
      @log.error 'teste'
      expect( @io.string ).to  end_with ": teste\n"
    end
    
    it 'fatal' do
      @log.level = Deployable::Logger::FATAL
      @log.fatal 'testf'
      expect( @io.string ).to  end_with ": testf\n"
    end
    
  end


  describe 'var' do

    before :each do
      @io  = StringIO.new
      @log = Deployable::Log.create @io
    end

    it 'trace' do
      @log.level = Deployable::Logger::TRACE
      @log.trace_var 'test',1
      expect( @io.string ).to  end_with ": test [1]\n"
    end

    it 'debug' do
      @log.level = Deployable::Logger::DEBUG
      @log.debug_var 'test',2
      expect( @io.string ).to  end_with ": test [2]\n"
    end
    
    it 'info' do
      @log.level = Deployable::Logger::INFO
      @log.info_var 'test',3
      expect( @io.string ).to  end_with ": test [3]\n"
    end

    it 'warn' do
      @log.level = Deployable::Logger::WARN
      @log.warn_var 'test',4
      expect( @io.string ).to  end_with ": test [4]\n"
    end

    it 'error' do
      @log.level = Deployable::Logger::ERROR
      @log.error_var 'test',5
      expect( @io.string ).to  end_with ": test [5]\n"
    end
    
    it 'fatal' do
      @log.level = Deployable::Logger::FATAL
      @log.fatal_var 'test',6
      expect( @io.string ).to  end_with ": test [6]\n"
    end

  end


  describe 'pair' do

    before :each do
      @io  = StringIO.new
      @log = Deployable::Log.create @io
    end

    it 'trace' do
      @log.level = Deployable::Logger::TRACE
      @log.trace_pair 'test', 1, 2,3
      expect( @io.string ).to  end_with ": test [1] 2 [3]\n"
    end

    it 'debug' do
      @log.level = Deployable::Logger::DEBUG
      @log.debug_pair 'test', 2,3,4
      expect( @io.string ).to  end_with ": test [2] 3 [4]\n"
    end
    
    it 'info' do
      @log.level = Deployable::Logger::INFO
      @log.info_pair 'test', 3,4,5
      expect( @io.string ).to  end_with ": test [3] 4 [5]\n"
    end

    it 'warn' do
      @log.level = Deployable::Logger::WARN
      @log.warn_pair 'test', 4,5,6
      expect( @io.string ).to  end_with ": test [4] 5 [6]\n"
    end

    it 'error' do
      @log.level = Deployable::Logger::ERROR
      @log.error_pair 'test', 5,6,7
      expect( @io.string ).to  end_with ": test [5] 6 [7]\n"
    end
    
    it 'fatal' do
      @log.level = Deployable::Logger::FATAL
      @log.fatal_pair 'test', 6,7,8
      expect( @io.string ).to  end_with ": test [6] 7 [8]\n"
    end

  end


end
