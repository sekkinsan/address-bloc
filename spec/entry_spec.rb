require_relative '../models/entry'
  #file is a spec file that tests Entry
RSpec.describe Entry do
  #use describe to give our test structure. Using it to communicate that the specs test the Entry attributes
  describe "attributes" do
    #DRY instead of adding an entry for each it
    let(:entry) { entry = Entry.new("Ada Lovelace", "010.012.1815", "augusta.king@lovelace.com")}
    #separate our individual tests using the it method, it represents a unique test
    it "responds to name" do
      #each RSpec test ends with one or more expect method, which we use to declare the expectations of the test.
      #if expectations are not met, test fails
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  #new describe block to separate the to_s test from the initializer tests, #to_s indicates it is an instance method
  describe "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new("Ada Lovelace", "010.012.1815", "augusta.king@lovelace.com")
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"

    #we use eq to check that to_s returns a string equal to expected_string
    expect(entry.to_s).to eq(expected_string)
    end
  end
end
