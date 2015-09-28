How to set up

```
rails new app_name -m https://raw.githubusercontent.com/voleoo/rails_template/master/template.rb
```

```
cap production deploy:setup
```
add to repository deployment key
```
cap production puma:monit:config
cap production sidekiq:monit:config
cap production deploy
```
