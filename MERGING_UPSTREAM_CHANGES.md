# Merging Upstream Changes

## Setup

```bash
git remote add upstream git@github.com:fluent/fluent-plugin-sql.git
```

## Phase 1: Validating Upstream Changes Locally

```bash
git checkout landing_pad
git pull
git fetch upstream
git merge upstream/master
# Resolve conflicts, etc.
bundle
# NOTE: It's important to use `bundle exec` here, as your gemset is now polluted with
# NOTE: mixed versions of dependencies (e.g. ActiveRecord)!
bundle exec rake test

# Stage and commit things here.

git push
```

## Phase 2: Merging Upstream Changes

```bash
git checkout master
git pull
git merge landing_pad
# Resolve conflicts, etc.
bundle clean --force
rake test

# Stage and commit things here.

git push
```
