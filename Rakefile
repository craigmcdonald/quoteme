

task :console do
  require 'pry'
  require_relative 'lib/quote_me'

  def reload!

    $LOADED_FEATURES.select {|f| f =~ /quote_me/ }.each do | file |
      load file 
    end

  end

  Pry.start
end

task c: :console