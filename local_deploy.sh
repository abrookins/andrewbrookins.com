#!/bin/bash
JEKYLL_ENV=production bundle exec jekyll build \
    && sudo -S rm -rf /var/www/jekyll && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/jekyll
