#!/bin/bash

file=/opt/dist/deployed.done

if [ ! -f $file ] ; then

  mkdir owncloud77
  cp -R * owncloud77/
  cd owncloud77/
  rm -R owncloud77/
  cd ..
  chown -R www-data owncloud77/
  service apache2 reload
  apt-get update
  apt-get install nano
  touch /opt/dist/deployed.done
  service apache2 start
  tail -f /var/log/dpkg.log
  
fi
