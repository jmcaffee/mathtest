require "spec_helper"

describe Mathtest::Generator do
  it "can be instantiated" do
    expect(Mathtest::Generator.new).not_to be nil
  end

  it "generates 'double' math problems" do
    gen = Mathtest::Generator.new
    gen.type = :doubles
    gen.lower_limit = 2
    gen.upper_limit = 3
    gen.operation = :times
    gen.count = 2
    gen.generate

    problem = gen.next_problem
    #puts problem.inspect
    expect(problem[:left]).to eq(problem[:right])
    expect(problem[:op]).to eq(:times)

    problem = gen.next_problem
    #puts problem.inspect
    expect(problem[:left]).to eq(problem[:right])
    expect(problem[:op]).to eq(:times)
  end

  it "generates 'standard' math problems" do
    gen = Mathtest::Generator.new
    #gen.type = :standard
    gen.lower_limit = 1
    gen.upper_limit = 10
    gen.operation = :addition
    gen.count = 11
    gen.generate

    12.times do
      problem = gen.next_problem
      expect(problem[:answer]).to_not eq "NaN"
      #puts problem.inspect
    end
  end

  it "generates valid simple division problems" do
    gen = Mathtest::Generator.new
    #gen.type = :standard
    gen.lower_limit = 1
    gen.upper_limit = 10
    gen.operation = :division
    gen.count = 11
    gen.generate

    12.times do
      problem = gen.next_problem
      expect(problem[:left] >= problem[:right]).to be true
      expect(problem[:left] % problem[:right]).to be 0
      expect(problem[:answer]).to_not eq "NaN"
      #puts problem.inspect
    end
  end

  it "generates valid simple subtraction problems" do
    gen = Mathtest::Generator.new
    #gen.type = :standard
    gen.lower_limit = 1
    gen.upper_limit = 10
    gen.operation = :subtraction
    gen.count = 11
    gen.generate

    12.times do
      problem = gen.next_problem
      expect(problem[:left] >= problem[:right]).to be true
      expect(problem[:answer]).to_not eq "NaN"
      #puts problem.inspect
    end
  end

  it "accepts valid operations" do
    gen = Mathtest::Generator.new

    gen.operation = :addition
    gen.operation = :subtraction
    gen.operation = :times
    gen.operation = :division
  end

  it "raises error on invalid operation" do
    gen = Mathtest::Generator.new

    expect { gen.operation = :divide }.to raise_error(ArgumentError)
  end
end
