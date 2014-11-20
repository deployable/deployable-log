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


class Logger < Logger

  # Add on TRACE to the logger class
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

private

  def build_var *args
    "#{args[0]} [#{args[1..args.length].join('] [')}]"
  end

  def build_pair *args
    args.each_slice(2).map{|name,var| "#{name} [#{var}]" }.join(' ')
  end

end


# A singleton interface to logger with 
# with some helper var loggers
module Log

  # Module instance variable to hold the logger
  @log = nil

  # Default output
  DefaultIO = STDOUT

  # returns the singleton
  def log
    Deployable::Log.log
  end

  # replace the logger with a new target
  def self.replace( io )
    l = Deployable::Logger.new io
    l.level = @log.level
    @log = l
  end

  # create a new logger
  def self.create io = DefaultIO, level = Deployable::Logger::INFO
    l = Deployable::Logger.new io
    l.level = level
    l
  end

  # return the singleton or create it
  def self.log
    @log ||= create
  end

end


end
