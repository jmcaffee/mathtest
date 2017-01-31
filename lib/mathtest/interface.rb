##############################################################################
# File::    interface.rb
# Purpose:: User interface
# 
# Author::    Jeff McAffee 01/27/2017
# Copyright:: Copyright (c) 2017, kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################

module Mathtest
  class Interface
    def show(problem)
      problem = Hash(problem)

      left = problem.fetch(:left)
      right = problem.fetch(:right)
      op = op_to_string(problem.fetch(:op))

      output = "#{left} #{op} #{right} = "
      $stdout.print output
      output
    end

    def print text
      $stdout.print text
    end

    def get_answer
      $stdin.gets.chomp
    end

    def ask text, default = nil
      print text
      print "[#{default}] " unless default.nil?

      ans = get_answer
      if ans.size == 0
        ans = default
      end

      ans
    end

    def op_to_string(op)
      str = case op
      when :times
        "x"
      when :division
        "/"
      when :addition
        "+"
      when :subtraction
        "-"
      else
        "nop"
      end
    end
  end
end # module
