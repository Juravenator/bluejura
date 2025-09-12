#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket


# https://github.com/aclap-dev/vdhcoapp/releases
VDHCOAPP_VERSION=2.0.19
# VDHCOAPP_DIR=$PWD
curl -LO https://github.com/aclap-dev/vdhcoapp/releases/download/v$VDHCOAPP_VERSION/vdhcoapp-noffmpeg-linux-x86_64.tar.bz2
# mkdir -p /opt/vdhcoapp
# tar xf vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 -C /opt/vdhcoapp --strip-components=1
mkdir -p /usr/bin /usr/libexec/vdhcoapp
# curl -L --silent https://github.com/aclap-dev/vdhcoapp/releases/download/v$VDHCOAPP_VERSION/vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 | tar xjf - \
# tar xf vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 \
#     --strip-components=1 \
#     -C $VDHCOAPP_DIR \
#     vdhcoapp-$VDHCOAPP_VERSION/vdhcoapp \
#     vdhcoapp-$VDHCOAPP_VERSION/filepicker \
#     vdhcoapp-$VDHCOAPP_VERSION/xdg-open

tar xf vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 \
    --strip-components=1 \
    -C /usr/bin \
    vdhcoapp-2.0.19/vdhcoapp

tar xf vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 \
    --strip-components=1 \
    -C /usr/libexec/vdhcoapp \
    vdhcoapp-$VDHCOAPP_VERSION/filepicker \
    vdhcoapp-$VDHCOAPP_VERSION/xdg-open

chmod 755 /usr/bin/vdhcoapp /usr/libexec/vdhcoapp/{filepicker,xdg-open}

rm vdhcoapp-noffmpeg-linux-x86_64.tar.bz2
# /usr/bin/vdhcoapp install