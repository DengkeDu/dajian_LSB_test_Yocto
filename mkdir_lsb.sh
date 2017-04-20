#!/bin/bash

# The first argument was release, e.g: release-5.0
# The second argument was arch, e.g: amd64 i486 ppc ppc64

# Install apache2
apt install apache2

# Set the /var/www was the root directory
# vi /etc/apache2/sites-available/000-default.conf
# Let the /var/www/html to /var/www
sed -i -e 's/html//' /etc/apache2/sites-available/000-default.conf
service apache2 restart

. ./packages_list

LSB_RELEASE=$1
LSB_ARCH=$2
BASE=/var/www
DOWNLOAD_SERVER=http://ftp.linuxfoundation.org

mkdir -p $BASE/pub/lsb/base/released-all/binary
mkdir -p $BASE/pub/lsb/test_suites/released-all/binary/runtime
mkdir -p $BASE/pub/lsb/test_suites/${LSB_RELEASE}/binary/runtime
mkdir -p $BASE/pub/lsb/app-battery/${LSB_RELEASE}/${LSB_ARCH}
mkdir -p $BASE/pub/lsb/app-battery/tests

cd $BASE/pub/lsb/base/released-all/binary

for pkg in ${BASE_PACKAGES_LIST}; do
    wget $DOWNLOAD_SERVER/pub/lsb/base/released-all/binary/${pkg}
done

cd $BASE/pub/lsb/test_suites/released-all/binary/runtime

for pkg in ${RUNTIME_BASE_PACKAGES_LIST}; do
    wget $DOWNLOAD_SERVER/pub/lsb/test_suites/released-all/binary/runtime/${pkg}
done

cd $BASE/pub/lsb/test_suites/${LSB_RELEASE}/binary/runtime

for pkg in ${RUNTIME_PACKAGES_LIST}; do
    wget $DOWNLOAD_SERVER/pub/lsb/test_suites/${LSB_RELEASE}/binary/runtime/${pkg}
done

cd $BASE/pub/lsb/app-battery/${LSB_RELEASE}/${LSB_ARCH}

for pkg in ${APP_PACKAGES_LIST}; do
    wget $DOWNLOAD_SERVER/pub/lsb/app-battery/${LSB_RELEASE}/${LSB_ARCH}/${pkg}
done

cd $BASE/pub/lsb/app-battery/tests

for pkg in ${APP_TESTFILES_LIST}; do
    wget $DOWNLOAD_SERVER/pub/lsb/app-battery/tests/${pkg}
done
