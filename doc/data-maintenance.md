# Data maintenance

## Maintaining the leaderboard

The query to generate the leaderboard is too slow and costly to be run live,
especially considering that it doesn't change very often, so it is instead
loaded from a JSON file, `tmp/{Rails.env}/leaderboard.json`, for example
`tmp/production/leaderboard.json`.

This file can be regenerated by running the rake task:

```
bundle exec leaderboard:calculate_and_store
```

The DataSciLab have also set up a cron job on the server, to run every day.

## Obtaining a current votes file

The rake task can be invoked with

```
bundle exec rake export_tsv
```

The resulting `votes.tsv` file will be stored in the `tmp` folder.
