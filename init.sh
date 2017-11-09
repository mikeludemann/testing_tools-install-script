#!/bin/bash

echo "Checking and installing testing tools"

apps=./apps.txt

if node -v > /dev/null; then
  if npm -v > /dev/null; then
    if [ -e "$apps" ]; then
      echo "File - apps.txt - exists"
      while read -r line
      do
        app=`echo $line | cut -d \; -f 1`
        npm install -g $app
      done < $apps
    else
      echo "File not exists"
    fi
  else
    echo "npm is not installed"
  fi
else
  echo "node is not installed"
fi

echo "Downloading Phantomjs with homebrew"
if brew -v  > /dev/null; then
  brew install phantomjs
else
  echo "homebrew is not installed"
fi

echo "Downloading PHPUnit and modified access and move to bin path"
if phpunit -version  > /dev/null; then
  curl https://phar.phpunit.de/phpunit.phar -L -o phpunit.phar
  chmod +x phpunit.phar
  mv phpunit.phar /usr/local/bin/phpunit
else
  echo "PHPUnit is not installed"
fi