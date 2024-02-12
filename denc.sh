#!/bin/bash

password="YourSuperSecretPassword"
verbose=false
encrypt() {
  [[ $verbose == true ]] && echo "Encrypted Text:"
  echo -n "$1" | openssl enc -aes256 -iter 10000 -pass "pass:$password" 2>/dev/null | base64 -w 0
  echo ""
}

decrypt() {
  [[ $verbose == true ]] && echo "Decrypted Text:"
  echo -n "$1" | tr -d '\n' | base64 -d 2>/dev/null | openssl aes256 -iter 10000 -d -pass "pass:$password"
  echo ""
}

encrypt_file() {
  [[ $verbose == true ]] && echo "Encrypting file: $1"
  openssl enc -aes256 -iter 10000 -pass "pass:$password" -in "$1" 2>/dev/null | base64 -w 0
  echo ""
}

decrypt_file() {
  [[ $verbose == true ]] && echo "Decrypting file: $1"
  base64 -d "$1" 2>/dev/null | openssl aes256 -iter 10000 -d -pass "pass:$password"
  echo ""
}

is_finished() {
  local input=""
  local consecutive_newlines=0
  while IFS= read -r line; do
    if [ -z "$line" ]; then
      consecutive_newlines=$((consecutive_newlines + 1))
      if [ "$consecutive_newlines" -ge 2 ]; then
        break
      fi
    else
      input="$input$line\n"
      consecutive_newlines=0
    fi
  done
  echo -e "$input"
}

if [ "$1" == "-v" ]; then
  verbose=true
  shift
fi

if [ "$1" == "-e" ] && [ "$2" == "-f" ] && [ -n "$3" ]; then
  encrypt_file "$3"
elif [ "$1" == "-f" ] && [ -n "$2" ]; then
  decrypt_file "$2"
elif [ "$1" == "-e" ]; then
  shift
  if [ -z "$1" ]; then
    verbose=true
    echo "Enter the text to encrypt (Press Enter twice to finish input):"
    input=$(is_finished)
    encrypt "$input"
    echo
  else
    encrypt "$1"
    echo
  fi
else
  if [ -z "$1" ]; then
    verbose=true
    echo "Enter the text to decrypt (Press Enter twice to finish input):"
    input=$(is_finished)
    if [ -n "$input" ]; then
      decrypt "$input"
      echo
    else
      echo "Error: No input provided."
    fi
  else
    decrypt "$1"
    echo
  fi
fi
