This is an absolute bare bone pure Ruby application that will perform RSA encryption and decryption of text files via the command line. 

Setup:

Generate your own RSA private/public key pair and save them in the correspondingly name files inside this app. 

Install dependencies: `gem install encrypto_signo` , `bundle install`

From the command line:

To encrypt a file:

`ruby runner.rb <<path_to_file_you_wish_to_encrypt.txt>>`

Application will encrypt the contents of the file using the public key and save it as <<original file>>_encrypted.txt.

To decrypt a file:

`ruby runner.rb <<path_to_file_you_wish_to_decrypt>>_encrypted.txt`

(file must end in `_encrypted.txt)

Application will automatically detect the `_encrypted.txt` in the file name, decrypt is using the private key, and save it, less the `_encrypted` bit.
