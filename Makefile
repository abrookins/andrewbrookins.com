
.PHONY: build deploy deps

deps:
	bundle install

build:
	JEKYLL_ENV=production bundle exec jekyll build

deploy: deps build
	JEKYLL_ENV=production bundle exec jekyll build \
		 && rsync -v -rz --checksum --delete _site/ andrew@andrewbrookins.com:_site \
		 && ssh -t andrew@andrewbrookins.com "sudo -S rm -rf /var/www/jekyll && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/jekyll"
