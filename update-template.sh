#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t\v'
cd `dirname "${BASH_SOURCE[0]:-$0}"`
set -x

if ! git remote get-url template &>/dev/null; then
    git remote add template git@github.com:ublue-os/image-template.git
fi
git fetch --all
git merge template/main --allow-unrelated-histories
