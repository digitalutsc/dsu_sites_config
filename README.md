# dsu_sites_config

## Add automate script of deploy [Dsu theme](https://github.com/digitalutsc/dsu_subtheme_barrioDepartments) for [isle-dc](https://github.com/digitalutsc/isle-dc/tree/islandora_lite)


````
wget wget https://raw.githubusercontent.com/digitalutsc/dsu_sites_config/exported_doris/all/patches/deploy-dsu-theme-for-makefile.patch
````

````
patch -p1 < deploy-dsu-theme-for-makefile.patch
````
