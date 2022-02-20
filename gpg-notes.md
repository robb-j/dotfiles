# yubikey gpg

[Setup and move a key to yubikey](https://developers.yubico.com/PGP/Importing_keys.html)

```sh
# Get public key to add to GitHub
gpg --armor --output example_pub.asc --export robanderson@hey.com

# List keys
gpg --list-secret-keys --keyid-format LONG robanderson@hey.com
```