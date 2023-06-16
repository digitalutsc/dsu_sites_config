.PHONY: install_dsu_theme
## Runs migrations of islandora
.SILENT: install_dsu_theme
install_dsu_theme:
	
	docker-compose exec -T drupal with-contenv bash -lc "wget -P /var/www/drupal https://raw.githubusercontent.com/digitalutsc/dsu_sites_config/main/composer_site.json"
	docker-compose exec -T drupal with-contenv bash -lc "rm composer.lock"
	docker-compose exec -T drupal apk add sudo
	docker-compose exec -T drupal with-contenv bash -lc 'chmod 777 /var/www/drupal/web/sites/default/settings.php'
	docker-compose exec -T drupal with-contenv bash -lc 'composer update'
	docker-compose exec -T drupal with-contenv bash -lc 'chmod 444 /var/www/drupal/web/sites/default/settings.php'
	docker-compose exec -T drupal with-contenv bash -lc "wget -P /var/www/drupal/web/sites/default/files https://digital.utsc.utoronto.ca/sites/default/files/logo.svg"
	docker-compose exec -T drupal with-contenv bash -lc "git clone -b advanced_search_template https://github.com/digitalutsc/dsu_subtheme_barrioDepartments.git /var/www/drupal/web/themes/contrib/dsu_subtheme_barrioDepartments"	
	docker-compose exec -T drupal with-contenv bash -lc "git clone https://github.com/digitalutsc/dsu_sites_config /var/www/drupal/dsu_sites_config"	
	docker-compose exec -T drupal drush -y then barriodepartments
	docker-compose exec -T drupal drush -y config-set system.theme default barriodepartments

	docker-compose exec -T drupal drush en -y structure_sync

	# enable theme settings
	docker-compose exec -T drupal drush -y config-import --partial --source=/var/www/drupal/dsu_sites_config/all/themes

	# import configs for TimelineJS
	#docker-compose exec -T drupal drush -y config-import --partial --source=/var/www/drupal/dsu_sites_config/all/timelinejs

	# import custom blocks
	docker-compose exec -T drupal drush ib

	# enable blocks 
	docker-compose exec -T drupal drush -y config-import --partial --source=/var/www/drupal/dsu_sites_config/all/blocks

	# clear cache
	docker-compose exec -T drupal drush cr

	docker-compose exec -T drupal drush -y config-set block.block.barriodepartments_miradorblock settings.iiif_manifest_url "/node/[node:nid]/book-manifest"
	
