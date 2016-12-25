#!/bin/bash
#jekyll build && rsync -v -rz --checksum --delete _site/ andrewbrookins.com:_site && ssh -t andrewbrookins.com 'sudo rm -rf /var/www/jekyll && sudo cp -r _site /var/www/jekyll && sudo chown -R www-data:www-data /var/www/jekyll'
JEKYLL_ENV=production bundle exec jekyll build \
    && rsync -v -rz --checksum --delete _site/ andrew@andrewbrookins.com:_site \
    && ssh -t andrew@andrewbrookins.com 'sudo rm -rf /var/www/jekyll && sudo cp -r _site /var/www/jekyll && sudo chown -R www-data:www-data /var/www/jekyll'
