This is an absolute bare-bones pure Ruby application that will perform RSA encryption and decryption of user provided text files via the command line. 

**Setup:**

* Generate your own RSA private/public key pair and save them in the correspondingly named files inside this app automically by running these two commands from the top level directory for the app.

  `$openssl genrsa -out lib/private.key 2048`
  `$openssl rsa -pubout -in path/to/private.key -out lib/public.key`

  (or insert your own existing keys)

* Install dependencies: 

  `$gem install encrypto_signo` , `bundle install`

**To use:**

From the command line:

* To encrypt a file:

  `$ruby runner.rb <<path_to_file_you_wish_to_encrypt.txt>>`

  Application will encrypt the contents of the file using the _public_ key and save it (in the top level directory of this app) as `<<original file>>_encrypted.txt`.

* To decrypt a file:

  `$ruby runner.rb <<path_to_file_you_wish_to_decrypt>>_encrypted.txt`

  (file _must_ end in `_encrypted.txt)

  Application will automatically detect the `_encrypted.txt` in the file name, decrypt it using the _private_ key, and save it as a new file, same name less the `_encrypted` bit (in the top level directory of this app).
