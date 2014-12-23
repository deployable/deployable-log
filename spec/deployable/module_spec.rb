require 'deployable/log'




describe Deployable::Log do

  describe 'simple' do

    before :all do

      class Test
        # logger for instance of the class
        include Deployable::Log
        class << self
          # logger for the class instance
          include Deployable::Log
        end
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

    it 'class logger goes into instance logger' do
      Test.new.log.info 'something'
      Test.log.info 'otherthing'
      expect( @io.string ).to  match( /.+?: something\n.+?: otherthing\n/m  )
    end


  end

end