"""RabbitMQ hashed password generator"""
# https://gist.github.com/anapsix/4c3e8a8685ce5a3f0d7599c9902fd0d5
# https://www.rabbitmq.com/passwords.html#computing-password-hash

import base64
import getpass
import hashlib
import os

# This is the password we wish to encode
password1 = getpass.getpass("password: ")
password2 = getpass.getpass("again: ")

if password1 != password2:
    print("passwords do not match")
    exit(1)

# 1.Generate a random 32 bit salt:
# This will generate 32 bits of random data:
salt = os.urandom(4)

# 2.Concatenate that with the UTF-8 representation of the password
tmp0 = salt + password1.encode("utf-8")

# 3. Take the SHA256 hash and get the bytes back
tmp1 = hashlib.sha256(tmp0).digest()

# 4. Concatenate the salt again:
salted_hash = salt + tmp1

# 5. convert to base64 encoding:
pass_hash = base64.b64encode(salted_hash)

print(pass_hash)
