# Design System Gem

Shared UI components, assets, and helpers for Rails apps.

## Installation

Add this to the host app's `Gemfile`:

```ruby
gem "design_system_gem",
  git: "https://github.com/udiskie/design_system_gem.git",
  branch: "master"
```

Then run:

```bash
bundle install
```

## Updating

1. Bump the version in `lib/design_system_gem/version.rb`
2. Commit and push to `master`
3. In the host app, run:

```bash
bundle update design_system_gem
```
