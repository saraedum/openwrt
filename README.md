ffulm OpenWrt firmware
======================

This is a fork of the OpenWrt repository at git://nbd.name/openwrt.git for the ffulm project (http://ulm.freifunk.net). The original README of the OpenWrt project is   in `README.openwrt`.

How to build the firmware
-------------------------

* `git clone` this repository
* in the `openwrt` directory you cloned do a `git submodule update --init`
* `./scripts/feeds update`
* `./scripts/feeds install -a`
* `make menuconfig` to set the `Target System` (usually `AR71xx/AR9xxx`) and the `Target Profile`; this sets sensible defaults for everything else
* `make`
* install the firmware, e.g., in `bin/ar71xx/`, following the guide for your box on the OpenWrt wiki
