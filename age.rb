puts "Enter the marks"
a = gets.chomp.to_i

puts case a
when 0..40
  "fail"

when 41..60
  "pass"

when 61..75
  "pass with second class"

when 76..85
  "first class"

when 86..100
	"distinction"
end