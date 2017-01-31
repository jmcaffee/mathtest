##############################################################################
# File::    generator.rb
# Purpose:: Generate math problems
# 
# Author::    Jeff McAffee 01/27/2017
# Copyright:: Copyright (c) 2017, kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################

module Mathtest
  class Generator
    attr_accessor :type
    attr_accessor :lower_limit
    attr_accessor :upper_limit
    attr_reader   :operation
    attr_accessor :count
    attr_reader   :index

    def initialize
      @index = 0
      @problems = Array.new
    end

    def operation=(op)
      raise ArgumentError, "Unknown operation: #{op}" unless [:addition, :subtraction, :division, :times].include?(op)
      @operation = op
    end

    def generate
      case type
      when :doubles
        generate_doubles
      when :standard,nil
        generate_standard
      else
        raise "Unknown generation type: #{type}"
      end
    end

    def generate_standard
      @problems = Array.new

      lefts = Array.new

      while lefts.size < count
        lefts += generate_number_list lower_limit, upper_limit
      end

      op = operation

      count.times do |i|
        num = generate_number lower_limit, upper_limit
        while !valid_nums(lefts[i], num, op)
          num = generate_number lower_limit, upper_limit
        end
        @problems << to_problem_hash(lefts[i], num, op)
      end
    end

    def valid_nums left, right, op
      if (op == :division or op == :subtraction)
        if right_le_left(left, right)
          if op == :division
            ( left % right ) == 0
          else
            true
          end
        end
      else
        true
      end
    end

    def right_le_left left, right
      right <= left
    end

    def generate_doubles
      @problems = Array.new

      nums = Array.new

      while nums.size < count
        nums += generate_number_list lower_limit, upper_limit
      end

      op = operation

      count.times do |i|
        @problems << to_problem_hash(nums[i], nums[i], op)
      end
    end

    def next_problem
      if index > (@problems.count - 1)
        @index = 0
      end

      problem = @problems[index]
      @index += 1
      problem
    end

    def to_problem_hash left, right, op
      answer = case op
      when :times
        left * right
      when :division
        left / right
      when :addition
        left + right
      when :subtraction
        left - right
      else
        "NaN"
      end

      { left: left, right: right, op: op, answer: answer }
    end

    def generate_number_list lower, upper
      num_list = Array.new
      output_list = Array.new

      (lower..upper).each do |i|
        num_list << i
      end

      len = num_list.size
      max = len + 1

      len.times do
        idx = rand(max)
        elem = num_list[idx]
        while elem.nil?
          idx = rand(max)
          elem = num_list[idx]
        end

        output_list << elem
        num_list[idx] = nil
      end

      output_list
    end

    def generate_number lower, upper
      rand(lower..upper)
    end
  end
end
