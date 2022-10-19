require 'openssl'
require 'base64'

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

  def rsa_key(key)
    OpenSSL::PKey::RSA.new(key)
  end

  # method from EncryptoSigno gem
  def encrypted_string
    aes_encrypt = OpenSSL::Cipher::Cipher.new('AES-256-CBC').encrypt
    aes_encrypt.key = aes_key = aes_encrypt.random_key
    crypt = aes_encrypt.update(file_contents) << aes_encrypt.final
    encrypted_key = rsa_key(public_key).public_encrypt(aes_key)
    [Base64.encode64(encrypted_key), Base64.encode64(crypt)].join("|")
  end

  # method from EncryptoSigno gem
  def decrypted_string
    encrypted_key, crypt = file_contents.split("|").map{|a| Base64.decode64(a) }
    aes_key = rsa_key(private_key).private_decrypt(encrypted_key)
    aes_decrypt = OpenSSL::Cipher::Cipher.new('AES-256-CBC').decrypt
    aes_decrypt.key = aes_key
    aes_decrypt.update(crypt) << aes_decrypt.final
  end

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
