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
curl -LO https://github.com/aclap-dev/vdhcoapp/releases/download/v2.0.19/vdhcoapp-noffmpeg-linux-x86_64.tar.bz2
rm -rf /opt/vdhcoapp
mkdir /opt/vdhcoapp
tar xf vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 -C /opt/vdhcoapp --strip-components=1
rm vdhcoapp-noffmpeg-linux-x86_64.tar.bz2
/opt/vdhcoapp/vdhcoapp install