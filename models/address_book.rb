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

  #Search AddressBook for a specific entry by name
  def binary_search(name)
    #save index of leftmost item in array in variable lower, rightmost in variable upper
    lower = 0
    upper = entries.length - 1

    #loop while our lower index <= upper index
    while lower <= upper
      #find middle index by (lower + upper)/2; Ruby truncates any decimal numbers
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      #compare name we're searching for to name of middle index, mid_name. use == operator when comparing to make the search case sensitive
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end
    #divide and conquer to the point where no match is found, then return nil
    return nil
  end

  #Iterative_search
  def iterative_search(name)
    #iterate over the entries until you find match
    @entries.each do |entry|
      if entry.name == name
        return entry
      end
    end
    return nil
  end
end
