# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## .env example

```
DEVISE_MFA_ENCRYPTION_KEY=0123456789abcdef0123456789abcdef
RECAPTCHA_SITE_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
RECAPTCHA_SECRET_KEY=yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
```

## config/master.key

```
a672f530cc26cb4d972604a86b4534d4
```

__CAUTION__

This Rails project is experimental.

You MUST NOT upload your own production Rails project's master.key file.

## Commands

```sh
bin/bundle
bin/rails db:setup
bin/rails s
```

## References

- https://qiita.com/Kta-M/items/e155f6e35e3e8274ff1e
- http://tango-ruby.hatenablog.com/entry/2016/01/21/191706
- https://github.com/ambethia/recaptcha
