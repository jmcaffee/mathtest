require "spec_helper"

describe Mathtest::Interface do
  it "can be instantiated" do
    expect(Mathtest::Interface.new).not_to be nil
  end

  it "displays a multiplication math problem" do
    problem = { left: 2, right: 3, op: :times, answer: 6 }
    expect(Mathtest::Interface.new.show(problem)).to eq("2 x 3 = ")
  end

  it "displays a division math problem" do
    problem = { left: 6, right: 3, op: :division, answer: 2 }
    expect(Mathtest::Interface.new.show(problem)).to eq("6 / 3 = ")
  end

  it "displays a addition math problem" do
    problem = { left: 2, right: 3, op: :addition, answer: 5 }
    expect(Mathtest::Interface.new.show(problem)).to eq("2 + 3 = ")
  end

  it "displays a subtraction math problem" do
    problem = { left: 3, right: 2, op: :subtraction, answer: 1 }
    expect(Mathtest::Interface.new.show(problem)).to eq("3 - 2 = ")
  end
end
