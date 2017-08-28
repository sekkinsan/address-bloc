require_relative 'controllers/menu_controller'

#creating new MenuController when AddressBloc starts
menu = MenuController.new

#use system "clear" to clear command line
system "clear"
puts "Welcome to AddressBloc!"

#call main_menu to display
menu.main_menu
