#!/bin/bash
JEKYLL_ENV=production bundle exec jekyll build \
    && rsync -v -rz --checksum --delete _site/ andrew@andrewbrookins.com:_site \
    && ssh -t andrew@andrewbrookins.com "echo $SSH_PASSWORD | sudo -S rm -rf /var/www/staging && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/staging"
