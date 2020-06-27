.PHONY: build deploy deps dev local_deploy local_deploy_staging

deps:
	bundle install

build: deps
	JEKYLL_ENV=production bundle exec jekyll build

dev: deps build
	JEKYLL_ENV=dev bundle exec jekyll serve --host=0.0.0.0

deploy: deps build
	JEKYLL_ENV=production bundle exec jekyll build \
		 && rsync -v -rz --checksum --delete _site/ andrew@andrewbrookins.com:_site \
		 && ssh -t andrew@andrewbrookins.com "sudo -S rm -rf /var/www/jekyll && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/jekyll"

local_deploy: deps build
	JEKYLL_ENV=production bundle exec jekyll build \
		&& sudo -S rm -rf /var/www/jekyll && sudo -S cp -r _site /var/www/jekyll && sudo -S chown -R www-data:www-data /var/www/jekyll

deploy_staging: deps build
	JEKYLL_ENV=production bundle exec jekyll build \
		&& rsync -v -rz --checksum --delete _site/ andrew@andrewbrookins.com:_site \
		&& ssh -t andrew@andrewbrookins.com "echo $SSH_PASSWORD | sudo -S rm -rf /var/www/staging && sudo -S cp -r _site /var/www/staging && sudo -S chown -R www-data:www-data /var/www/staging"

local_deploy_staging: deps build
	JEKYLL_ENV=production bundle exec jekyll build \
		&& sudo -S rm -rf /var/www/staging && sudo -S cp -r _site /var/www/staging && sudo -S chown -R www-data:www-data /var/www/staging
