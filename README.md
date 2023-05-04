# Bespoked bike sales tracking app 
BeSpoked is a high-end bicycle shop and each salesperson gets a commission for each bike they sell.


### Clone the repository

```shell
git clone git@github.com:prativapokhrel/bespoked_bikes_sales_tracking_api.git
cd bespoked_bikes_sales_tracking_api
```

#

## Prerequisites

The setup steps expect following tools installed on the system.

- Ruby [3.2.2](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [6.1.7.3](https://github.com/organization/project-name/blob/master/Gemfile#L12)

#### Check your Ruby version

```shell
ruby -v
```

If it is not isntalled then, install the ruby version using [rvm](https://github.com/rvm/rvm)
Firstly, install rvm then run this command to install ruby:

```shell
rvm install 3.2.2
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Database Setup 
```shell
rails db:create db:migrate db:seed
```

##### 4. Start the Rails server

```ruby
bundle exec rails s
```

### Tests
RSpec has been used for writing tests 
```
bundle exec rspec 
```

