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

    def get_test_configuration
      test = Hash.new

      print("======  MATHTEST v#{Mathtest::VERSION}  ======\n\n")

      test[:count] = ask("How many problems? ", "10").to_i
      test[:type] = :standard
      if ask("Test doubles (y/n) ", "n") == "y"
        test[:type] = :doubles
        test[:operation] = :times
      else
        op = get_operation
        while ! [:addition, :subtraction, :times, :division].include? op
          op = get_operation
        end
        test[:operation] = op
      end

      print("\n")
      test[:lower_limit] = ask("What is the lowest operand possible? ", "1").to_i
      test[:upper_limit] = ask("What is the highest operand possible? ", "10").to_i

      test[:success_percent] = ask("What score percentage ends the test (1-100)? ", "90").to_i

      test
    end

    def get_operation
      print("\n")
      print("--- Operations ---\n\n")

      print("    addition:       a\n")
      print("    subtraction:    s\n")
      print("    multiplication: m\n")
      print("    division:       d\n")
      print("\n")
      op = ask(" Problem operations (a/s/m/d)? ", "m")

      op = case op
      when 'a'
        :addition
      when 's'
        :subtraction
      when 'm'
        :times
      when 'd'
        :division
      else
        op
      end

      op
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
