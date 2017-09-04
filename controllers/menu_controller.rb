require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    #display main menu options to terminal
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "6 - View Entry Number n"
    puts "7 - DESTROY ALL EVIDENCE"
    print "Enter your selection: "

    #retrieve user input fromcommand line using gets(gets reads the next line from standard input)
    selection = gets.to_i
    #use case to determine the proper response to the user's input
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      puts "Good-bye!"
      #exit(0) terminates the program
      exit(0)
    when 6
      system "clear"
      view_entry_number
      main_menu
    when 7
      system "clear"
      destroy
      main_menu
      #use else to catch invalid user input and prompt retry
    else
      system "clear"
      puts "Sorry, invalid selection"
      main_menu
  end
end

#stub rest of methods called in main_menu
def view_all_entries
  #iterate through all entries using each
  address_book.entries.each do |entry|
    system "clear"
    puts entry.to_s

    #call entry_submenu to display a submenu for each entry
    entry_submenu(entry)
  end

  system "clear"
  puts "End of entries"
end

def view_entry_number
  #user inputs entry number
  print "Entry Number: "
  entry_number = gets.chomp
  entry_number = entry_number.to_i

  found_entry = nil

  address_book.entries.each_with_index do |entry, index|
    if index == entry_number - 1
      found_entry = entry
      break
    end
  end

  if found_entry.nil?
    print "Invalid Entry Number"
  else
    print found_entry.to_s
  end
end

def create_entry
  #clear screen before creating entry prompts
  system "clear"
  puts "New AddressBloc Entry"
  #use print to prompt the user for each Entry attribute
  print "Name: "
  name = gets.chomp
  print "Phone Number: "
  phone_number = gets.chomp
  print "Email: "
  email = gets.chomp

  #add new entry to address_Book using add_entry to ensure that new entry is added in proper order
  address_book.add_entry(name, phone_number, email)

  system "clear"
  puts "New Entry created"
end

def delete_entry(entry)
  address_book.entries.delete(entry)
  puts "#{entry.name} has been deleted"
end

def edit_entry(entry)
  #perform series of print statements followed by gets.chomp assignment statement, each gets.chomp gathers user input and assigns it to an appropriately named variable
  print "Updated name: "
  name = gets.chomp
  print "Updated phone number: "
  phone_number = gets.chomp
  print "Updated email: "
  email = gets.chomp
  #use !attribute.empty? to set attributes on entry only if a valid attribute was read from user input
  entry.name = name if !name.empty?
  entry.phone_number = phone_number if !phone_number.empty?
  entry.email = email if !email.empty?
  system "clear"
  #print out entry with updated attributes
  puts "Updated entry:"
  puts entry
end

def search_entries
  #we get name user wants to search for and store it
  print "Search by name: "
  name = gets.chomp
  #call search on address_book which will either return a match or nil, won't ever return an empty string since import_from_csv will fail if an entry has no name
  match = address_book.binary_search(name)
  system "clear"
  #check if search returned a match. if it did, we call helper method called search_submenu
  if match
    puts match.to_s
    search_submenu(match)
  else
    puts "No match found for #{name}"
  end
end

def read_csv
  #prompt user to enter name of CSV file to import using STDIN and call chomp method to remove newlines
  print "Enter CSV file to import: "
  file_name = gets.chomp

  #check to see if file name is empty, if it is, we return user to main menu
  if file_name.empty?
    system "clear"
    puts "No CSV file read"
    main_menu
  end

#import specified file with import_from_csv on address_book, claer screen and print number of entries that were read from file
#we use begin/rescue block; begin will protect the program from crashing if an exception is thrown
#if program performs an illegal operation (ex dividing a number by 0), Ruby will throw an exception
#program is allowed to continue executing at the rescue statement
#begin/rescue block catches potential exceptions and handles them by printing an error message and calling import_from_csv again
  begin
    entry_count = address_book.import_from_csv(file_name).count
    system "clear"
    puts "#{entry_count} new entries added from #{file_name}"
  rescue
    puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
    read_csv
  end
end

def destroy
  address_book.entries.clear
  puts "All evidence has been destroyed"
  main_menu
end

def entry_submenu(entry)
  #display submenu options
  puts "n - next entry"
  puts "d - delete entry"
  puts "e - edit this entry"
  puts "m - return to main menu"

  #chomp removes any trailing whitespace from the string gets returns
  selection = gets.chomp

  case selection
    #user asks to see next entry, we can do nothing and control will be returned to view_all_entries
  when "n"
    #we'll handle deleting and editing in another checkpoint, for now user will see next entry
  when "d"
    #when we press d, we call delete_entry, after it's deleted, control will return to view_all_entries and next entry will be displayed.
    delete_entry(entry)
  when "e"
    #we call edit_entry when user presses e, then display sub-menu with entry_submenu for the entry under edit.
    edit_entry(entry)
    entry_submenu(entry)
    #we return user to main menu w m
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    puts "#{selection} is not a valid input"
    entry_submenu(entry)
  end
end

#search_submenu displays a list of operations that can be performed on an Entry, give user ability to delete or edit an entry and return to main menu when match is found
def search_submenu(entry)
  #print submenu for an entry
  puts "\nd - delete entry"
  puts "e - edit this entry"
  puts "m - return to main menu"
  #save user input to selection
  selection = gets.chomp
  #case statement and take specific action based on user input
  case selection
  when "d"
    system "clear"
    delete_entry(entry)
    main_menu
  when "e"
    edit_entry(entry)
    system "clear"
    main_menu
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    puts "#{selection} is not a valid input"
    puts entry.to_s
    search_submenu(entry)
  end
end

end
