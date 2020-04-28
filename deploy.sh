#!/bin/bash
HOST=167.71.159.137
JEKYLL_ENV=production bundle exec jekyll build \
    && rsync -v -rz --checksum --delete _site/ andrew@$HOST:_site \
    && ssh -t andrew@$HOST "echo $SSH_PASSWORD | sudo -S rm -rf /var/www/jekyll && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/jekyll"
