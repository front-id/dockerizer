#!/usr/bin/env bash

# Removes all generated files and folders.

echo ''
echo ''
echo -e "\e[32mA continuación se borrarán todos los ficheros generados automáticamente para este proyecto."
echo -e "\e[0m"
echo ''

while ! { test "$cleanup" = 'y' || test "$cleanup" = 'n'; }; do
  read -p "¿Estás seguro? [Y/n]: " cleanup

  if [[ ${cleanup,,} = 'n' ]]; then
    echo 'Cancelando el borrado.'
    exit 0
  fi

  if [[ ${cleanup,,} = '' || ${cleanup,,} = 'y' ]]; then
    cleanup='y'
  fi
done

# Remove all the files and directories generated by intall.sh.
echo 'Borrando todos los ficheros generados por setup.sh.'
rm -rf docker html mariadb-init storage docker-compose.yml .dockerizer-project.ini