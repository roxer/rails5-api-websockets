## README


* Ruby version - 2.2.3

* Configuration

```
brew install rbenv
rbnev install 2.2.3
brew install redis
brew services redis start
git clone git@github.com:roxer/rails5-api-websockets.git && cd rails5-api-websockets
bundle install
```

* Database initialization

```
bundle exec rake db:setup
```

* How to run the test suite - TODO

* Services (job queues, cache servers, search engines, etc.) - TODO

* Deployment instructions - TODO

* Local demo

```
cd rails5-api-websockets
bundle exec puma -p 28080 cable/config.ru
cd rails5-api-websockets
bundle exec rails server

open url - http://localhost:3000/swagger#/
open url 1 browser - http://localhost:3000/messages
open url 2 browser - http://localhost:3000/messages
open url 3 browser - http://localhost:3000/messages
```



config/initializers/ams_json_adapter.rb
config/initializers/inflections.rb

HACK
swager docs - add to base_path "//" at the end

TODO
api_key for authorization
travis.ci or jenkins for continous integration
changer json format (e.g. ember requires root node)

