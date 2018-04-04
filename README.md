# Plogger

## Introduction

Plogger stands for Papinotas Logger or Phoenix Logger (our current project, which raised the need for this gem). Plogger is a simple logging gem which receives a little more information than `Rails.Logger`, and can also send an exception to third party APIs (currently only Raven is supported). Plogger outputs the log in a parser friendly format, ready for other software such as Logstash to process it.

## Configuring

```ruby
# environments/[Environment].rb
Rails.application.configure do
  Plogger.configure do |config|
    config.logger = ActiveSupport::Logger.new(STDOUT) # Or whatever logger you want to configure
    config.module = 'MainModule' # Optional
    config.raven_dsn = 'http://public:secret@example.com/project-id' # Optional
  end
end
```

## Usage

The usage is similar to how you use the Rails Logger, but you can also log exceptions.

```ruby
begin
  1/0
rescue e
  trace = Plogger.exception(e, category: 'Bundle Creation')
  # => trace = "130AH93MWS2"
  return render "Too bad, an exception was raised. Read the full error at #{trace}"
end
trace_2 = Plogger.info("Processing ready", category: 'Bundle Creation')
render "Your process finished successfully, check the logs at #{trace_2}"
```

Plogger has the following methods: `exception`, `error`, `warning`, `info`, `debug`. It will use the logger you supplied in the config to output them, so make sure you have enabled the log level you are trying to use.

## Params

Each of these methods can receive the following keyword params:

| Param         | Explanation   | Default   |
| ------------- |---------------|-----------|
| category      | Use it to categorize the thing you are logging, so you can later group related logs in Kibana or something |''|
| user_id      | Use it to track the user that is generating the log | ''
| account_id | In Phoenix we use accounts (a user can have many accounts). You can track that too | '' |
| extra_info | A hash with additional tags you can print in the log | {} |

Example call:

```ruby
Plogger.info("Processing ready", category: "Bundle Creation", user_id: 1, extra_info: {happy: "yes"})
# Will output 'Processing ready -- category='Bundle Creation' user_id=1 happy='yes'
```