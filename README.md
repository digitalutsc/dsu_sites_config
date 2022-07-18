# dsu_sites_config

## For for [isle-dc](https://github.com/digitalutsc/isle-dc/tree/islandora_lite)

###  Deploy [Dsu theme](https://github.com/digitalutsc/dsu_subtheme_barrioDepartments) 

````
wget https://raw.githubusercontent.com/digitalutsc/dsu_sites_config/exported_doris/all/patches/deploy-dsu-theme-for-makefile.patch
patch -p1 < deploy-dsu-theme-for-makefile.patch
````

Run: 
````
cd isle-dc
make deploy-dsu-theme
````

### Deploy Federated Search 

````
wget https://raw.githubusercontent.com/digitalutsc/dsu_sites_config/main/federated-search/patches/deploy-federated-search.patch
patch -p1 < deploy-federated-search.patch
````

Run: 
````
cd isle-dc
make deploy-federated-search
````

## For [playbook](https://github.com/digitalutsc/islandora-playbook/tree/islandora_lite)

### Deploy [Dsu theme](https://github.com/digitalutsc/dsu_subtheme_barrioDepartments) for [isle-dc](https://github.com/digitalutsc/isle-dc/tree/islandora_lite)

````
git clone https://github.com/digitalutsc/islandora_lite_installation.git
cd {{ path }}/islandora_lite_installation/scripts
./install_theme.sh
````

### Deploy Federated Search 

````
git clone https://github.com/digitalutsc/islandora_lite_installation.git
cd {{ path }}/islandora_lite_installation/scripts
./federated_search.sh
````
