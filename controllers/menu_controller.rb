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

def search_entries
end

def read_csv
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
  when "e"
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
end
