require_relative '../models/address_book'

RSpec.describe AddressBook do

#create new instance of AddressBook model and assign it to variable named book
#using the let syntax, lets us use book in all our tests, removing duplication for each test
  let(:book) {AddressBook.new}

#created helper method check_entry which consolidates redundant code
def check_entry(entry, expected_name, expected_number, expected_email)
  expect(entry.name).to eq expected_name
  expect(entry.phone_number).to eq expected_number
  expect(entry.email).to eq expected_email
end

#we use describe and it to explain what we are testing in RSpec
  describe "attributes" do
    it "responds to entries" do
      expect(book).to respond_to(:entries)
      book.import_from_csv("entries.csv")
      #check the first entry
      entry_one = book.entries[0]
      check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
  end

  it "imports the 2nd entry" do
    book.import_from_csv("entries.csv")
    #check second entry
    entry_two = book.entries[1]
    check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
  end

  it "imports the 3rd entry" do
    book.import_from_csv("entries.csv")
    #check third entry
    entry_three = book.entries[2]
    check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
  end

  it "imports the 4th entry" do
    book.import_from_csv("entries.csv")
    #check fourth entry
    entry_four = book.entries[3]
    check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
  end

  it "imports the 5th entry" do
    book.import_from_csv("entries.csv")
    #check fifth entry
    entry_five = book.entries[4]
    check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
  end

  #AddressBook should initialize entries as an empty array
  it "initializes entries as an array" do
    expect(book.entries).to be_an(Array)
  end

  it "initializes entries as empty" do
    expect(book.entries.size).to eq(0)
  end
end

describe "#add_entry" do
  it "adds only one entry to the address book" do
    book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

    expect(book.entries.size).to eq(1)
  end

  it "adds the correct information to entries" do
    book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    new_entry = book.entries[0]

    expect(new_entry.name).to eq('Ada Lovelace')
    expect(new_entry.phone_number).to eq('010.012.1815')
    expect(new_entry.email).to eq('augusta.king@lovelace.com')
  end
end

describe "#remove_entry" do
  it "removes only one entry from the address book" do
    book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

    name = "Ada Lovelace"
    phone_number = "010.012.1815"
    email = "augusta.king@lovelace.com"

    expect(book.entries.size).to eq(1)
    book.remove_entry(name, phone_number, email)
    expect(book.entries.size).to eq(0)
  end
end

#test that AddressBook's .import_from_csv() method is working correctly
describe "#import_from_csv" do
  it "imports the correct number of entries" do
    #call import_from_csv method on the book object which is of type AddressBook (our model)
    #pass import_from_csv the string entries.csv as a parameter
    #reference AddressBook.entries variable to get its size in an Array
    #save the size of the AddressBook.entries to our local variable
    book.import_from_csv("entries.csv")
    book_size = book.entries.size

    #Check the size of the entries in AddressBook
    expect(book_size).to eq 5
  end
end

describe "importing from entries2.csv" do
  it "imports the correct number of entries" do
    book.import_from_csv("entries_2.csv")
    book_size = book.entries.size

    #Check size of entries in AddressBook
    expect(book_size).to eq 3
  end

  it "imports the 1st entry" do
    book.import_from_csv("entries_2.csv")
    #check first entry
    entry_one = book.entries[0]
    check_entry(entry_one,"Jane","555-555-5555","jane@blocmail.com")
  end

  it "imports the 2nd entry" do
    book.import_from_csv("entries_2.csv")
    #check second entry
    entry_two = book.entries[1]
    check_entry(entry_two,"Jessica","555-555-5124","jessica@blocmail.com")
  end

  it "imports the 3rd entry" do
    book.import_from_csv("entries_2.csv")
    #check third entry
    entry_three = book.entries[2]
    check_entry(entry_three,"Justine","555-555-1902","justine@blocmail.com")
  end
end

#test the binary_search method
  describe "#binary_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bob")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Joe")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sally")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sussie")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Billy")
      expect(entry).to be_nil
    end
  end

end
