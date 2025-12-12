#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 
dnf copr enable -y bsvh/fw-ectool
dnf install -y fw-ectool

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
VDHCOAPP_DIR=/usr/bin
mkdir -p /usr/bin /usr/libexec/vdhcoapp
curl -L --silent https://github.com/aclap-dev/vdhcoapp/releases/download/v$VDHCOAPP_VERSION/vdhcoapp-noffmpeg-linux-x86_64.tar.bz2 | tar xjf - \
    --strip-components=1 \
    -C $VDHCOAPP_DIR \
    vdhcoapp-$VDHCOAPP_VERSION/vdhcoapp \
    vdhcoapp-$VDHCOAPP_VERSION/filepicker 

chmod 755 /usr/bin/vdhcoapp /usr/bin/{filepicker,vdhcoapp}

cat > /usr/lib/tmpfiles.d/vdhcoapp.conf <<'EOF'
# Firefox expects these in /opt
L /opt/vdhcoapp/vdhcoapp   - - - - /usr/bin/vdhcoapp
L /opt/vdhcoapp/filepicker - - - - /usr/bin/filepicker
L /opt/vdhcoapp/xdg-open   - - - - /usr/bin/xdg-open
EOF

/usr/bin/vdhcoapp install

mkdir -p /nix && \
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix -o /nix/determinate-nix-installer.sh && \
	chmod a+rx /nix/determinate-nix-installer.sh
