# BrandingRepo (for Rails)

Ever had the problem that you reuse the same project for a managemable number of clients? To few to store branding materials in a database, but more than one making it hard to keep separate branches in sync?

Introducing BrandingRepo (for Rails)

The idea is simple: create a configuration file with those files that are specific to different brands/customers and store their mods in a different repository. Repository is quite a big word here: we simply create a `config/brands` folder in your current branch where you can push and pull your brand specific adjustments from. All managed in the same git repository.

What it is not:

- it is not git within git.
- it is not a design system, nor has it anything to do with it (I think perhaps with a few additional hacks it can be made to work with centrally managed gems/node-modules; like here: https://twitter.com/hopsoft/status/1451358882161332225?s=10)
- it is not adding brand icons to your project

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'branding_repo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install branding_repo

## Usage

Set up a default branding:

```
$ rails branding:create default
```

This will create a `config/branding.yml` file with a list of files to copy on a brand change.

It is suggested that you create a neutral 'default' brand, and make variations from it.

```
$ rails branding:push default
```

Now create a new brand:

```
$ rails branding:create org_name
```

Do your thing in making brand specific changes and push them

```
$ rails branding:push org_name
```

Before committing everything to remote, you might want to switch back to the default branch:

```
$ rails branding:pull default
```

This pull, but then for a specific brand, is also something you do just before building your image / assets.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Todo

* Write some tests 😱
* Make it work without Rails

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/branding_repo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/branding_repo/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BrandingRepo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/branding_repo/blob/master/CODE_OF_CONDUCT.md).
