require 'spec_helper'

describe 'Deployable::Log module include' do

  describe 'simple' do

    before :all do

      class TestThis
        # logger for instance of this class and the class instance itself
        include Deployable::Log
      end

      @io  = StringIO.new
      @log = Deployable::Log.log
      Deployable::Log.replace_log @io
    end

    it 'has a class logger' do
      expect( TestThis.log ).to  be_a Deployable::Logger 
    end

    it 'has an instance logger' do
      expect( TestThis.new.log ).to  be_a Deployable::Logger 
    end

    it 'class logger goes into instance logger' do
      TestThis.new.log.info 'something'
      TestThis.log.info 'otherthing'
      expect( @io.string ).to  match( /.+?: something\n.+?: otherthing\n/m  )
    end


  end

end