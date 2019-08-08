#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1
apt-get -y install chromium-chromedriver
# before_install
gem update --system
gem --version
# install
ruby -S bundle install
# before_script
ln -s /usr/lib/chromium-browser/chromedriver ~/bin/chromedriver
google-chrome-stable --headless --disable-gpu --remote-debugging-port=9222 http://localhost &
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter
./cc-test-reporter before-build
# script
bin/citest