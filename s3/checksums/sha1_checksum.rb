# require 'zlib'
# crc32 = Zlib::crc32(File.read("myfile.txt"))
# puts crc32

require "digest"
puts Digest::SHA1.file("myfile.txt")