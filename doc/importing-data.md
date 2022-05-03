# Importing data from the old site

## Prerequisites

- The app is running and the database has been initialized
- You have CSV database dumps from the old MySQL database in the format
  `vote_export_TIMESTAMP.csv` and `place_export_TIMESTAMP.csv`
- The places CSV has the following columns:
  - id
  - image_uri
  - geograph_uri
  - type
  - title
  - description
  - subject
  - creator
  - creator_uri
  - date_submitted
  - lat
  - lon
  - gridsquare
  - license_uri
  - format
  - votes
  - rand
  - width
  - height
  - aspect
- The votes CSV has the following columns:
  - id
  - place
  - uuid
  - rating
  - token
  - ip
  - user_agent

(These columns should be what is automatically exported from MySQL, so the list
above is just belt and braces)

## Running the import

Once you have the CSV files, copy them to the `db/data` directory and rename
them to `votes.csv` and `places.csv` respectively (replacing the files that are
already there).

Run the following command in the root of the project:

```bash
FULL_IMPORT=1 bundle exec rake db:migrate
```

Please note: This may take a while, but be assured, it is working!
