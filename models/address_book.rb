#we tell Ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    #we create a variable to store the insertion index
    index = 0
    entries.each do |entry|
      #we compare name with current entry
      #if name lexicographically proceeds entry.name, we've found the index to insert at
      #otherwise we increment index and continue comparing with other entires
      if name < entry.name
        break
      end
      index += 1
    end
      #we insert a new entry into entries using the calculated index
      entries.insert(index, Entry.new(name, phone_number, email))
    end

  def remove_entry(name, phone_number, email)
    delete_entry = nil

    entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
        delete_entry = entry
      end
    end
    entries.delete(delete_entry)
  end

#defined import_from_csv; method starts by reading CSV file and then parsing it.
#result of CSV.parse is an object of type CSV::Table
  def import_from_csv(file_name)
    #implementation here
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    #iterate over CSV::Table object rows, creating a hash for each row
    #convert each row_hash to an Entry by using the add_entry method which will also add Entry to AddressBook entries
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end
end
