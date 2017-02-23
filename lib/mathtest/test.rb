##############################################################################
# File::    test.rb
# Purpose:: Encapsulate a 'test', a set of math problems
# 
# Author::    Jeff McAffee 01/29/2017
# Copyright:: Copyright (c) 2017, kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################

module Mathtest
  class Test

    attr_reader   :interface
    attr_reader   :generator
    attr_accessor :count
    attr_accessor :type
    attr_accessor :operation
    attr_accessor :success_percent
    attr_accessor :lower_limit
    attr_accessor :upper_limit

    attr_reader   :correct_count

    def initialize(_interface = Mathtest::Interface.new,
                   _generator = Mathtest::Generator.new)
      @interface = _interface
      @generator = _generator
      @count = 10
      @type = :standard
      @operation = :times
      @success_percent = 0
      @upper_limit = 10
      @lower_limit = 1
      @correct_count = 0
    end

    def execute
      executing = true
      while executing
        interface.clear_screen

        configure_generator
        generator.generate

        @correct_count = 0

        count.times do
          problem = generator.next_problem
          interface.show(problem)
          answer = interface.get_answer

          if answer == String(problem[:answer])
            @correct_count += 1
          else
            interface.print(" "*14)
            interface.print("Incorrect. The correct answer is #{problem[:answer]}\n")
            # FIXME: keep track of failing problems and 'review' them after the test.
          end
        end

        display_results

        executing = correct_percent < success_percent
      end
    end

    def configure_generator
      generator.count = count
      generator.type = type
      generator.operation = operation
      generator.lower_limit = lower_limit
      generator.upper_limit = upper_limit
    end

    def display_results
      interface.print("\n--- RESULTS ---\n")
      interface.print("\n")
      interface.print("    (#{correct_count}/#{count}):   #{correct_count} of #{count} answered correctly\n")

      correct_perc = correct_percent
      punctuation = "!!!"
      punctuation = "." if correct_perc < 70

      interface.print("    You scored #{correct_perc}%#{punctuation}\n\n")
    end

    def correct_percent
      return 0.0 if correct_count == 0
      return 100.0 if count == 0
      (Float(correct_count) / Float(count)) * 100
    end
  end
end
