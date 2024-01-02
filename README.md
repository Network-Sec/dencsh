# denc.sh
denc.sh is a simple, symetric de- and encode tool - so you can savely store your API keys within your public writeup.

## Symmetric En- / Decode
Text-to-text, e.g. for storage in my public notebook. It's silent by default, so you can use it like this:

```bash
$ x="api: $(denc.sh U2FsdGVkX19xH9ng7T7pbNxMLdPfl28sr69wsbK1JWZI9RkIwqWPa5ddJy+iruJ0fizAS8H9Uw==)"
$ echo $x
api: lJX543DKIuEnYWKsdgtwrF3ie
```

### Usage
```bash
# Encrypt
$ denc.sh -e texttoencrypt

# Decrypt
$ denc.sh U2FsdGVkX18+PtTlXJhRRXruO0litWChUbxejJeLWHKgkhQ==

# Multiline input mode encrypt
$ denc.sh -e 

# Multiline input mode decrypt
$ denc.sh 
```
