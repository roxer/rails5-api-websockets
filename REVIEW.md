# Install

```
copy and edit .env_tmpl
edit /etc/hosts => 127.0.0.1	ws.dev

bundle exec rails db:setup
foreman start
```

You can use docker-compose but there is a problem with websockets

```
docker-compose build
dokcer-compose up
docker exec -it web bundle exec rails db:setup
```

upload files http://localhost:3000/data_files/new


# Key solutions

run 
```
bundle exec rails notes:custom ANNOTATION=REVIEW
bundle exec rails notes:custom ANNOTATION=HACK
bundle exec rails notes

or using silver searcher
ag REVIEW .
```

# TODO

specs and test



