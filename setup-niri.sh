#!/usr/bin/env bash
# setup-niri.sh — turn a Fedora 45 minimal install into a niri + waybar desktop
#
#   sudo bash ~/setup-niri.sh
#
# Safe to re-run: dnf install is idempotent.
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
    echo "Run this with sudo: sudo bash $0" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# RPM Fusion (free + non-free) repositories
# ---------------------------------------------------------------------------
# Fedora does not ship some codecs/drivers (full ffmpeg, VA-API freeworld
# drivers, etc.). RPM Fusion provides them. Installing the release RPM is
# the supported method: it drops the rpmfusion-*.repo files (under
# /usr/share/dnf5/repos.d on F45) and installs the signing keys.
# Must run before the package install below.
echo "==> Enabling RPM Fusion (free + non-free)"
fedora_ver=$(rpm -E %fedora)
for repo in free nonfree; do
    if rpm -q "rpmfusion-${repo}-release" &>/dev/null; then
        echo "    rpmfusion-${repo}-release already installed"
    else
        dnf install -y "https://mirrors.rpmfusion.org/${repo}/fedora/rpmfusion-${repo}-release-${fedora_ver}.noarch.rpm"
    fi
done

# Import the signing keys explicitly. The repo files point gpgkey at
# /usr/share/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-*-fedora-$releasever, which the
# release RPM above installs; importing up front avoids an interactive
# prompt the first time a package is pulled from these repos.
for repo in free nonfree; do
    key=/usr/share/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-${repo}-fedora-${fedora_ver}
    if [[ -f $key ]]; then
        rpm --import "$key"
    fi
done
