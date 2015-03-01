require 'spec_helper'

describe Deployable::Log do


  describe 'initial' do

    it 'has a version number' do
      expect(Deployable::Log::VERSION).not_to be nil
    end

    
  end


  describe 'module include' do

    it 'can get a log instance' do
      expect( Deployable::Log.log ).not_to be nil
    end

    it 'gets the same instance' do
      expect( Deployable::Log.log ).to be Deployable::Log.log
    end

    it 'log_level' do
      expect( Deployable::Log.log_level(1) ).to be 1
    end

    it 'log_level name' do
      expect( Deployable::Log.log_level :DEBUG ).to be 0
    end

    it 'log_level via symbol' do
      expect( Deployable::Log.log_level 'DEBUG' ).to be 0
    end

  end

end