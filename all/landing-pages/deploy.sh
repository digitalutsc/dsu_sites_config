#!/bin/bash

echo "Enter the site URL:"
read site_url

echo "Enter username of Drupal account: "
read username

echo "Enter password of Drupal account: "
read password

authentication=`echo -n "${username}:${password}" | base64`

echo "Enter the site path (ie: /var/www/html/drupal):"
read site_path

echo "Enter the current path of dsu_sites_config (run pwd and copy the output, ie: /var/www/html/drupal/dsu_sites_config)"
read app_path

echo "Do you want to include Exibits components (Yes or No)"
read include_exhibit

# change to the site path
`cd ${site_path}`

# Download composer_site
wget https://raw.githubusercontent.com/digitalutsc/dsu_sites_config/main/all/landing-pages/composer_site.json

# Download needed modules with composer update
sudo composer update


# Enable needed modules
sudo drush then -y bootstrap_barrio
sudo drush en -y hero_banner
sudo drush en -y bootstrap_slideshow

# Create a homepage
echo "Creating the landing page node ...."
new_node=`curl --location --request POST ${site_url}'/node?_format=hal_json' \
--header 'Content-Type: application/hal+json' \
--header 'Authorization: Basic '${authentication} \
--data-raw '{
    "_links": {
        "type": {
            "href": "'${site_url}'/rest/type/node/landing_page"
        }
    },
    "type": [
        {
            "target_id": "landing_page"
        }
    ],
    "title": [
        {
            "value": "Landing Page for this site"
        }
    ],
    "body": [
        {
            "value": "This is description"
        }
    ]
}'`

command="python3 ./new_node.py '${new_node}'"
node_id=$(eval ${command})
echo ${node_id}

# setup the homeage as <front>
drush -y config-set system.site page.front "/node/"${node_id}

if [ "include_exhibit" != "${include_exhibit#[Yy]}" ] ;then # this grammar (the #[] operator) means that the variable $answer where any Y or y in 1st position will be dropped if they exist.
    #import all components which set by the prompt
    drush -y config-import --partial --source="${app_path}"/dsu_sites_config/memory/exhibits
fi





