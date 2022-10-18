require './lib/encryptor'

if ARGV[0].include?('_encrypted.txt')
  Encryptor.new(ARGV[0]).decrypt
else
  Encryptor.new(ARGV[0]).encrypt
end
