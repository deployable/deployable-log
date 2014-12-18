require 'deployable/log'




describe Deployable::Log do

  describe 'simple' do

    before :all do

      class Test
        include Deployable::Log
      end

      @io  = StringIO.new
      @log = Deployable::Log.log
      Deployable::Log.replace @io
    end

    it 'has a class logger' do
      expect( Test.log ).to  be_a Deployable::Logger 
    end

    it 'has an instance logger' do
      expect( Test.new.log ).to  be_a Deployable::Logger 
    end

  end

end