# Archangel

** Archangel is currently under development. It is not ready for production use. **

[![Travis CI](https://travis-ci.org/archangel/archangel.svg?branch=master)](https://travis-ci.org/archangel/archangel)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ecd913526457e79b49bd/test_coverage)](https://codeclimate.com/github/archangel/archangel/test_coverage)
[![Code Climate](https://codeclimate.com/github/archangel/archangel/badges/gpa.svg)](https://codeclimate.com/github/archangel/archangel)
[![Inline docs](http://inch-ci.org/github/archangel/archangel.svg?branch=master)](http://inch-ci.org/github/archangel/archangel)

![Archangel](archangel.png "Archangel")

Archangel is a Rails CMS.

This project rocks and uses MIT-LICENSE.

[Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

## Deploying to Heroku

Deploy a sample application to [Heroku](https://www.heroku.com/) to play with.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/archangel/sample)

## Requirements

* Ruby >= 2.4.6
* Rails ~> 5.1

Additional requirements for `development` and `test` environment:

* Google Chrome
  * Install using [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) with `brew cask install google-chrome`
* Chromedriver
  * Install using [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) with `brew cask install chromedriver`

## Installation

Add to your application's Gemfile

```
gem "archangel", "~> 0.3"
```

Run the bundle command

```
$ bundle install
```

Run the install generator

```
$ bundle exec rails g archangel:install
```

Run the install generator with seed data

```
$ bundle exec rails g archangel:install --seed
```

Seed data can be created separately by running `bundle exec rails db:seed`

## Updating

Subsequent updates can be done by bumping the version in your application Gemfile, then installing new migrations

```
$ bundle exec rails archangel:install:migrations
```

Run migrations

```
$ bundle exec rails db:migrate
```

## Code Analysis

* [Travis CI](https://travis-ci.org/) is used for running tests.
* [Code Climate](https://codeclimate.com/) is used to analyze overall maintainability.

## Developers

General documentation for developers

* [Contributing Guide](https://github.com/archangel/archangel/blob/master/CONTRIBUTING.md)
* [Documentation for Archangel gem developers](https://github.com/archangel/archangel/blob/master/docs/Developers.md)
* [Documentation for extension developers](https://github.com/archangel/archangel/blob/master/docs/Extension/Developers.md)
* [Documentation for theme developers](https://github.com/archangel/archangel/blob/master/docs/Theme/Developers.md)
* [Documentation for releasing a gem version](https://github.com/archangel/archangel/blob/master/docs/Release.md) (maintainers only)

## Special Thanks

Archangel's logo was created by [Joshua Boyd](http://www.joshadamboyd.com/).

[@archangel-dlt](https://github.com/archangel-dlt/) originally had the "archangel" gem name and were kind enough to give it up

## Contributing

A [contributing guide](https://github.com/archangel/archangel/blob/master/CONTRIBUTING.md) is available.

1. Fork it ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
