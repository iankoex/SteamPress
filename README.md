<p align="center">
    <img src="https://user-images.githubusercontent.com/9938337/29742058-ed41dcc0-8a6f-11e7-9cfc-680501cdfb97.png" alt="SteamPress">
</p>
<h1 align="center">SteamPress</h1>
<p align="center">
  <a href="https://swift.org">
      <img src="http://img.shields.io/badge/Swift-5.7-brightgreen.svg" alt="Language">
  </a>
  <a href="https://github.com/iankoex/SteamPress/actions/workflows/tests.yml">
      <img src="https://github.com/iankoex/SteamPress/actions/workflows/tests.yml/badge.svg" alt="Build Status">
  </a>
  <a href="https://raw.githubusercontent.com/iankoex/SteamPress/main/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  </a>
</p>

SteamPress is an opensource blogging engine and platform written in swift.

# Features

* Code syntax highlighting
* WYSIWYG Markdown editor
* Tagging selection
* Content Security Policy and other security headers
* Embeddable tweets
* Facebook/Twitter share buttons
* Blog post editor auto saving
* Open Graph/Twitter Card support
* Blog Post comments, powered by Disqus
* Custom 404 error page

# Usage

You can find a docker image at [iankoex/steampress](https://hub.docker.com/repository/docker/iankoex/steampress/general). 
You can also clone the repo and run it on your machine.

Required env variables
- `SP_WEBSITE_URL` - The url of your domain, e.g `SP_WEBSITE_URL="https://example.com"`
- `DATABASE_CLIENT`- The database client of your choice. Postgres is recommended. Available options: `psql`, `mysql` and `sqlite`.
- `DATABASE_URL`   - The database url of your client. sqlite does not require url.

Optional env variable
- `SP_BLOG_PATH`  - The subpath you want your blog to resolve. e.g for `SP_BLOG_PATH="blog"` your blog will be available at `https://example.com/blog`

The admin page for your blog will be availble at `https://example.com/steampress` if no `SP_BLOG_PATH` was set or `https://example.com/blog/steampress` if was set.


