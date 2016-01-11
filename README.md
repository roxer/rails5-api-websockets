## README

[![CI build by travis-ci.org](https://travis-ci.org/roxer/rails5-api-websockets.svg?branch=master)](https://travis-ci.org/roxer/rails5-api-websockets)
[![Dependency Status](https://gemnasium.com/roxer/rails5-api-websockets.png)](https://gemnasium.com/roxer/rails5-api-websockets)
[![Coverage Status](https://coveralls.io/repos/roxer/rails5-api-websockets/badge.png?branch=master&service=github)](https://coveralls.io/github/roxer/rails5-api-websockets?branch=master)
[![Code Climate](https://codeclimate.com/github/roxer/rails5-api-websockets.png)](https://codeclimate.com/github/roxer/rails5-api-websockets)

* Ruby version - 2.2.3

* Configuration

```sh
brew install rbenv
rbnev install 2.2.3
brew install redis
brew services redis start
git clone git@github.com:roxer/rails5-api-websockets.git && cd rails5-api-websockets
./bin/setup
```

* How to run the test suite

```sh
bundle exec rspec spec
```

* Services (job queues, cache servers, search engines, etc.) - TODO

* Deployment instructions - TODO

* Docker setup

```sh
docker-machine start default
eval "$(docker-machine env default)"
docker-compose build
docker-compose run --rm web rake db:setup
docker-machine ls
docker-machine ip default
add to /etc/hosts "docker.machine.ip.result ws.local"
docker-compose up

open url 1 browser - http://ws.local:3000/messages
open url 2 browser - http://ws.local:3000/messages
open url 3 browser - http://ws.local:3000/messages
open url - http://ws.local:3000/swagger
```

* Local demo

```sh
cd rails5-api-websockets
bundle exec puma -p 28080 cable/config.ru
cd rails5-api-websockets
cp .env_tmpl .env
cp .env_tmpl .env.test
bundle exec rails server

open url 1 browser - http://localhost:3000/messages
open url 2 browser - http://localhost:3000/messages
open url 3 browser - http://localhost:3000/messages
open url - http://localhost:3000/swagger
```

HACK
swager docs - add to base_path "//" at the end

TODO
api_key for authorization
travis.ci or jenkins for continous integration
changer json format (e.g. ember requires root node)

config/initializers/ams_json_adapter.rb
config/initializers/inflections.rb


