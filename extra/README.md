# Tiime extra

This directory contains a script that retrieves a token usable with Tiime API.

## Usage

First run:

```
bundle install
```

```
export TIIME_USER=john.doe@example.com
export TIIME_PASSWORD=Supersecret
# or
# export TIIME_PASSWORD=`pass show web/apps.tiime.fr/john.doe@example.com | head -n1`
bundle exec ./get_token
```
