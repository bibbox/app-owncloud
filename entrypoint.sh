#!/bin/bash

file=/opt/dist/deployed.done

if [ ! -f $file ] ; then

  mkdir §§INSTANCENAME
  cp -R * §§INSTANCENAME/
  cd §§INSTANCENAME/
  rm -R §§INSTANCENAME/
  cd ..
  chown -R www-data §§INSTANCENAME/
  service apache2 reload
  apt-get update
  apt-get install nano
  touch /opt/dist/deployed.done
  service apache2 start
  tail -f /var/log/dpkg.log
  
fi
