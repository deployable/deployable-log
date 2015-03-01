require "deployable/log/version"
require 'logger'

### Log - a global logger instance for classes
#
# Allows you to call a single logger instance easily from your classes
#
#     class Yours
#       include Log
#       def method
#         log.info 'something'
#       end
#     end

module Deployable


  # Create a custom instance of the Ruby `logger`. 
  # We add a bunch of hlper log methods
  class Logger < Logger

    # Add on TRACE to the logger class
    TRACE = -1
    module Severity;
      TRACE = -1
    end
    include Severity
    def trace( progname = nil, &block )
      add( TRACE, nil, progname, &block )
    end
    def trace?; @level <= TRACE; end



    def trace_each tag, iter #, &block
      return if @level > TRACE
      iter.each do |m|
        add( TRACE, nil, "#{tag} #{m}" )
      end
    end

    def debug_each tag, iter #, &block
      return if @level > DEBUG
      iter.each do |m|
        add( DEBUG, nil, "#{tag} #{m}" )
      end
    end

    def info_each tag, iter #, &block
      return if @level > INFO
      iter.each do |m|
        add( INFO, nil, "#{tag} #{m}" )
      end
    end

    def error_each tag, iter #, &block
      return if @level > ERROR
      iter.each do |m|
        add( ERROR, nil, "#{tag} #{m}" )
      end
    end

    def fatal_each tag, iter #, &block
      return if @level > FATAL
      iter.each do |m|
        add( FATAL, nil, "#{tag} #{m}" )
      end
    end


    # Var loggers
    def trace_var *args, &block
      return if @level > TRACE
      message = block_given? ? build_var(yield) : build_var(*args)
      add( TRACE, nil, message )
    end

    def debug_var *args, &block
      return if @level > DEBUG
      message = block_given? ? build_var(yield) : build_var(*args)
      add( DEBUG, nil, message )
    end

    def info_var *args, &block
      return if @level > INFO
      message = block_given? ? build_var(yield) : build_var(*args)
      add( INFO, nil, message )
    end

    def warn_var *args, &block
      return if @level > WARN
      message = block_given? ? build_var(yield) : build_var(*args)
      add( WARN, nil, message )
    end

    def error_var *args, &block
      return if @level > ERROR
      message = block_given? ? build_var(yield) : build_var(*args)
      add( ERROR, nil, message )
    end

    def fatal_var *args, &block
      return if @level > FATAL
      message = block_given? ? build_var(yield) : build_var(*args)
      add( FATAL, nil, message )
    end


    # Pair loggers
    def trace_pair *args, &block
      return if @level > TRACE
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( TRACE, nil, message )
    end

    def debug_pair *args, &block
      return if @level > DEBUG
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( DEBUG, nil, message )
    end

    def info_pair *args, &block
      return if @level > INFO
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( INFO, nil, message )
    end

    def warn_pair *args, &block
      return if @level > WARN
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( WARN, nil, message )
    end

    def error_pair *args, &block
      return if @level > ERROR
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( ERROR, nil, message )
    end

    def fatal_pair *args, &block
      return if @level > FATAL
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( FATAL, nil, message )
    end


    # Fatal and error to raise
    def fatal_raise error, *args, &block
      return if @level > FATAL
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( FATAL, nil, message )
      raise error, message
    end

    def error_raise error, *args, &block
      return if @level > ERROR
      message = block_given? ? build_pair(yield) : build_pair(*args)
      add( ERROR, nil, message )
      raise error, message
    end

  private

    # Creates a string of vars log:
    #    message text [var1] [var2] [var3]
    def build_var *args
      line =  "#{args[0]}"
      # bracket [] any additional arguments
      line << " [#{args[1...args.length].join('] [')}]" if args.length > 1
      line
    end

    # Creates a string of pairs to log (useful for hashes too)
    #    var1 [val1] var2 [val2]
    def build_pair *args
      args = args.to_a unless args.respond_to? :each_slice
      args.each_slice(2).map{|name,var| "#{name} [#{var}]" }.join(' ')
    end

  end


  # A singleton interface to the Deployable logger
  # 
  module Log

    # Default output
    DefaultIO = STDOUT


    class << self

      # create a new logger
      # Doesn't impact the singleton
      def create_log io = DefaultIO, level = ::Deployable::Logger::INFO
        l = ::Deployable::Logger.new io
        l.level = level
        l
      end

      # Replace the singleton logger with a new target/level
      def replace_log io = DefaultIO, level = @log.level
        l = ::Deployable::Logger.new io, level
        #l.level = @log.level
        @log = l
      end

      # Set the level for the logger
      def log_level level
        level = Deployable::Logger.const_get level.upcase unless 
          level.kind_of? ::Fixnum

        @log.level = level
      end

      # Add `.log` to the instance of the class
      # Return the singleton or create it
      def log 
        @log #||= Log.create
      end

      # Add `.log` to the class instance on include
      def included base
        class << base
          def log
            Deployable::Log.log
          end
        end
      end

    end

    # Module instance variable to hold the singleton logger instance
    @log = create_log

    # Adds `.log` method to the class instance to return the singleton
    def log
      ::Deployable::Log.log
    end

  end


end
