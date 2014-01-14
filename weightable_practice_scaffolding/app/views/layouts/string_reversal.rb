"hello"
"olleh"

def string_reversal(string)
  # get string length to know how long string array will be

  string_length = string.length 
  # create array to push letters into 
  string_array = []
  # take each letter and push into 
  a = string.split('').each do |x|
      string_array.push(x)
    end


    counter = string.length
    a.each do |x|
      string_array - (counter - 1)
      puts x
    end
    
    puts string_array

end