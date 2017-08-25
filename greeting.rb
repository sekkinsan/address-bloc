def greeting
  what_to_say = ARGV.shift
  ARGV.each do |arg|
    puts "#{what_to_say} #{arg}"
  end
end

greeting
