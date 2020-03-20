How to set up

```
rails new app_name -m https://raw.githubusercontent.com/voleoo/rails_template/master/template.rb
```
```
rails new app_name -m ./rails_template/template.rb
```
```
rails app:template LOCATION=./rails_template/template.rb
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



```
rails new project_name --skip-webpack-install -T -d postgresql -m rails_template/template_version2.rb
```
```
rails new project_name -T -d postgresql
```
```
cd project_name
```
```
rails app:template LOCATION=../rails_template/template_version2.rb
```
```
rails app:template LOCATION=https://raw.githubusercontent.com/voleoo/rails_template/master/install_database.rb
```

```
rails app:template LOCATION=../rails_template/install_rspec.rb
```
