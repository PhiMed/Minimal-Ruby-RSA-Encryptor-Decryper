require 'encrypto_signo'

class Encryptor
  attr_accessor :user_provided_file

  def initialize(user_provided_file)
    @user_provided_file = user_provided_file
  end

  def encrypt
    write_to_file(encrypted_string, encrypted_output_file_path)
    puts "#{user_provided_file} was encrypted using public key and saved as #{encrypted_output_file_path}"
  end

  def decrypt
    write_to_file(decrypted_string, decrypted_output_file_path)
     puts "#{user_provided_file} was decrypted using private key and saved as #{decrypted_output_file_path}"
  end

  private 

  def file_contents
    file = File.open(user_provided_file)
    results = file.read
    file.close
    results
  end

  def write_to_file(string, path)
    file = File.new(path, mode: "w")
    file.write(string)
    file.close
  end

  def encrypted_string
    EncryptoSigno.encrypt(public_key, file_contents)
  end

  def decrypted_string
    EncryptoSigno.decrypt(private_key, file_contents)
  end

  def encrypted_output_file_path
    "#{user_provided_file.chomp('.txt')}_encrypted.txt"
  end

  def decrypted_output_file_path
    "#{user_provided_file.chomp('_encrypted.txt')}.txt"
  end
  
  def public_key
    File.read("lib/public.key")
  end 

  def private_key
    File.read("lib/private.key")
  end
end
