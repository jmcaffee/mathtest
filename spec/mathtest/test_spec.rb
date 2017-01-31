require "spec_helper"

describe Mathtest::Test do
  it "can be instantiated" do
    expect(Mathtest::Test.new).not_to be nil
  end

  it 'uses an Mathtest::Generator by default' do
    test = Mathtest::Test.new

    expect(test.generator.class).to eq Mathtest::Generator
  end

  it 'uses an Mathtest::Interface by default' do
    test = Mathtest::Test.new

    expect(test.interface.class).to eq Mathtest::Interface
  end

  it 'stores a count' do
    test = Mathtest::Test.new

    test.count = 11
    expect(test.count).to eq 11
  end

  it 'count defaults to 10' do
    test = Mathtest::Test.new

    expect(test.count).to eq 10
  end

  it 'stores a type' do
    test = Mathtest::Test.new

    test.type = :doubles
    expect(test.type).to eq :doubles
  end

  it 'type defaults to :standard' do
    test = Mathtest::Test.new

    expect(test.type).to eq :standard
  end

  it 'stores an operation' do
    test = Mathtest::Test.new

    test.operation = :addition
    expect(test.operation).to eq :addition
  end

  it 'operation defaults to :times' do
    test = Mathtest::Test.new

    expect(test.operation).to eq :times
  end

  it 'stores a target success percentage' do
    test = Mathtest::Test.new

    test.success_percent = 99
    expect(test.success_percent).to eq 99
  end

  it 'target success percentage defaults to 0' do
    test = Mathtest::Test.new

    expect(test.success_percent).to eq 0
  end

  it 'stores an upper limit' do
    test = Mathtest::Test.new

    test.upper_limit = 100
    expect(test.upper_limit).to eq 100
  end

  it 'upper limit defaults to 10' do
    test = Mathtest::Test.new

    expect(test.upper_limit).to eq 10
  end

  it 'stores a lower limit' do
    test = Mathtest::Test.new

    test.lower_limit = 10
    expect(test.lower_limit).to eq 10
  end

  it 'lower limit defaults to 1' do
    test = Mathtest::Test.new

    expect(test.lower_limit).to eq 1
  end

  it 'can be executed' do
    ispy = create_interface_spy
    test = Mathtest::Test.new(ispy)
  end

  context '#execute' do
    it 'displays math problems' do
      ispy = create_interface_spy
      test = Mathtest::Test.new(ispy)

      test.success_percent = -1
      test.execute
      expect(ispy.show_count).to eq 10
    end
  end
end
