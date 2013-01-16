# This file contains functions specific to the setup of the ffulm community.

# Apply some common replacements to a config file passed as the first argument.
apply_ffulm_replacements_inplace() {
	# set the hostname to four random hex digits if it is still 'OpenWrt' 
	hostname=$(uci_get system @system[0] hostname OpenWrt)
	[ "$hostname" = "OpenWrt" ] && {
		uci_set system @system[0] hostname $(printf 0x$(ifconfig eth0|grep 'HWaddr'|md5sum|head -c4)|awk '{printf("%04x",int($1*65000/65535+535)) }')
		uci_commit
	}
	hostname=$(uci_get system @system[0] hostname)

	sed -i "s/HOSTNAME_REPLACED_DURING_NEXT_BOOT/$hostname/g" "$1"

	# if the user hasn't screwed with the hostname this should be four random hex digits on first boot
	$(echo "$hostname" | awk '{ if($0 !~ /^[0-9a-f]{4}$/) exit 1; }') && (
		random_v6="2a01:348:12f:"$(uci_get system @system[0] hostname)"::1"

		sed -i "s/V6_ADDRESS_REPLACED_DURING_NEXT_BOOT/$random_v6/g" "$1"
	)
}
