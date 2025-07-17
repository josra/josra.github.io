# 2025 - update to build locally

I wanted to read some of the blogs in this post, and needed the site to build again.

Hmmm - there wasn't any instructions on how to get that up and running , so I made a few changes:

- Added a jekyll aware `.devcontainer` simply open this project in VS Code and reload in the container
- Added a simple `Gemfile` and from that generated a `Gemfile.lock`
- Instructed the `_config.yml` to exclude some files from the build:
```yaml
exclude:
  - Gemfile*
  - LICENSE
  - README*
  - CONTRIBUTING
  - /docs # ignore Minimal Mistakes /docs
```
- Updated `.gitignore` to ignore `**cache*`
- Moved `LayoutDesign.md` and `linkchecker_ignore_urls.txt` to the `docs` folder.
- Added `CONTRIBUTING`