## Install
For installing server, just run `vagrant up`, it will install all the necessary dependencies.

After that, connect via `vagrant ssh` to virtual machine, change directory to `estudy` folder and run this commands:

* `rake db:create` - created database for test and development environment
* `rake db:migrate` - run all the migrations
* `rake db:seed` - create all seeds

After that, run `sidekiq` command inside `estudy` directory.
Run rails server via `rails s -v 0.0.0.0`

## Requirements

Except `rails`, for proper server-side work (with vagrant or not) you need lason:

* [Redis](http://redis.io/)
* [ElasticSearch](https://www.elastic.co/products/elasticsearch)
* [Sidekiq](http://sidekiq.org/)
