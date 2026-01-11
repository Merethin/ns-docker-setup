# ns-docker-setup

Docker Compose file to run several of my NS services which depend on each other in tandem

## Base Services

RabbitMQ (to communicate), PostgreSQL (to store data), [Akari](https://github.com/Merethin/Akari) (shared SSE client)

## Optional Services

- [Bubble](https://github.com/Merethin/Bubble)
- [Vanille](https://github.com/Merethin/Vanille)
- [crystal](https://github.com/Merethin/crystal)

## Non-Services / One-time Services

This repository has a shell script ([download-dumps.sh](scripts/download-dumps.sh)) that uses [swash](https://github.com/Merethin/swash) to download the daily data dumps and store the parsed contents in the database.

There is a template shell script ([daily-post-major.sh](scripts/daily-post-major.sh)) that first executes this, and then any other commands added by you to process the data.

[scripts/crontab](scripts/crontab) can be modified to point to daily-post-major.sh, with the path it's located at on your system, and then installed into cron so that it is run daily at 7:30am UTC (about one hour after major).

## Note on Database Tables

Any service that requires certain database tables to be set up (Akari with Postgres enabled, Vanille, swash) will need to have the tables created manually beforehand. The code for their tables can be found in the respective service's sql/ folder.

## Setup

Clone the repo with `git clone --recursive`.

Place your configuration files for each service you will use in config/. Akari has a pre-filled one enabling only the RabbitMQ output, you can edit this if you like. The Vanille configuration file is also pre-filled as it is incredibly simple.

## Environment

Create an .env file with the following variables:

```
USER_AGENT=[...]
DATABASE_PASSWORD=[...]
RABBITMQ_PASSWORD=[...]
COMPOSE_PROFILES=[...]
```

`USER_AGENT` should be set to your main nation name. The `PASSWORD` variables should be set to a sufficiently secure password of your liking.

`COMPOSE_PROFILES` should be used to select which optional services you want to run. If running Bubble and Vanille, set `COMPOSE_PROFILES=bubble,vanille`, for example.

If using Vanille, add `VANILLE_TOKEN=[...]` set to the Discord bot token Vanille will use.

## Running

Start everything up with `docker compose up -d`.

The first run will probably take a good amount of time to compile everything. After that, everything is up!
