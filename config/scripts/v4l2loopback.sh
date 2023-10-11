#!/usr/bin/env bash

set -oeux pipefail

### BUILD v4l2loopback (succeed or fail-fast with debug output)
rpm-ostree install \
    akmod-v4l2loopback \
    v4l2loopback
