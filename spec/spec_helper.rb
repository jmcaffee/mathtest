$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "mathtest"

class InterfaceSpy

  attr_accessor :show_count
  attr_accessor :print_count
  attr_accessor :input_count

  def initialize
    @show_count = 0
    @print_count = 0
    @input_count = 0
  end

  def show(problem)
    @show_count += 1
  end

  def print(text)
    @print_count += 1
  end

  def get_answer
    @input_count += 1
  end
end

def create_interface_spy
  InterfaceSpy.new
end
