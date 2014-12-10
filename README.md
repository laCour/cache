# Cache

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This is Ruby on Rails application for sharing content in exchange for digital currency. [Watch a realtime transaction.](https://www.mediacru.sh/VA-PxAiyx-Fc)

![Screenshot](https://www.mediacru.sh/2/2qRQ7SmiD0gU.png)

## Running Locally

Once you have installed [Ruby](https://www.ruby-lang.org/), [Bundler](http://bundler.io/), and the [Heroku Toolbelt](https://toolbelt.heroku.com/) the application can be initialized using the following commands:

```
git clone https://github.com/lacour/cache.git
cd cache
bundle
rake bootstrap
```

Once you [configure](#configuration) the application, you can start the application using `foreman start`. The application should now be running on [localhost:5000](localhost:5000).

## Deploying to Heroku

```
heroku create
git push heroku master
heroku run rake bootstrap
heroku open
```

In order for payouts to work, you must first enable the Heroku Scheduler add-on to run `rake cron`:

```
heroku addons:add scheduler:standard
heroku addons:open scheduler
```

## Configuration

All software configuration is conveniently placed within the `config/config.yml` file. Here, you can change the name of the application, set custom fees, change the digital currency being used, and more.

### Third Party Configuration

This software also requires the use of two third parties, [Amazon S3](https://aws.amazon.com/s3/) for file hosting, and [Block.io](https://block.io/) for handling digital currencies. Registration is required for both.

The software will check for the following environment variables for each service. The environment variables can be [defined in a file](https://github.com/bkeepers/dotenv#usage) named `.env` during development, and also by using the [Heroku toolbelt](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application) for setting these in production.

```
S3_BUCKET=
S3_KEY=
S3_SECRET=
BLOCKIO_KEY=
BLOCKIO_PIN=
```

## Warning

This software is not intended for production use. If you wish to use this software for production use, I highly suggest removing the dependency of Block.io for deposits/payouts. This was only used to keep the application slim for ++++. I recommend the [bitcoin-ruby](http://rubygems.org/gems/bitcoin-ruby) gem for Bitcoin or Litecoin.