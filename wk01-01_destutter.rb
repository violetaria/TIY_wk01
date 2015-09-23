def destutter(array)
  result = [] # Array.new
  last_val = nil
  array.each do |cur_val|
    result.push(cur_val) if(cur_val!=last_val)
    last_val = cur_val
  end
  result
end

def removeDupes(array)
  result = [] # Array.new
  array.each { |cur_val| result.push(cur_val) unless result.include?(cur_val) }
  result
  # cheating :) array.uniq
end

test_array = [1, 2, 3, 3, 4, 4, 3, 2, 1, 1]
puts "start = #{test_array}"
new_array = destutter(test_array)
puts "end = #{new_array}"

test_array2 = [1, 2, 2, 3, 2, -1]
puts "start = #{test_array2}"
new_array = destutter(test_array2)
puts "end = #{new_array}"

test_array = [1, 2, 3, 3, 4, 4, 3, 2, 1, 1]
puts "start = #{test_array}"
new_array = removeDupes(test_array)
puts "end = #{new_array}"