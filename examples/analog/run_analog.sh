#!/bin/sh
#
# Simple shell script to create different types of statistics
#
# Example config file for analog creating some statistics
#
# Project    : ipv6calc/ipv6logconv
# File       : run_analog.sh
# Version    : $Id: run_analog.sh,v 1.4 2002/03/16 19:25:39 peter Exp $
# Copyright  : none
# Procuded   : 2002 by Peter Bieringer <pb (at) bieringer.de>

umask 007

LOGFILE="../access_log"

BIN_IPV6LOGCON="../../ipv6logconv"

FILE_TMP="/tmp/access_log.combined"

CONFIG_ANALOG="analog-dist.cfg"
DIR_BASE="."

if [ ! -d "$DIR_BASE" ]; then
	echo "Missing base directory: $DIR_BASE"
	exit 2
fi

if [ ! -r "$CONFIG_ANALOG" ]; then
	echo "Missing or unreadable analog config file: $CONFIG_ANALOG"
	exit 2
fi

#set -x

type="$1"

case "$type" in
    "dedicated")
	## dedicated files version
	# Create address type statistics
	echo "addrtype..."
	cat $LOGFILE | $BIN_IPV6LOGCON --out addrtype | analog +g$CONFIG_ANALOG +C'HOSTNAME Address_type_distribution' +O$DIR_BASE/distribution-addrtype/analog.html 

	echo "ipv6addrtype..."
	# Create IPv6 address type statistics
	cat $LOGFILE | $BIN_IPV6LOGCON --out ipv6addrtype | analog +g$CONFIG_ANALOG +C'HOSTNAME IPv6_address_type_distribution' +O$DIR_BASE/distribution-ipv6addrtype/analog.html 
	# Create OUI statistics
	echo "ouitype..."
	cat $LOGFILE | $BIN_IPV6LOGCON --out ouitype | analog +g$CONFIG_ANALOG +C'HOSTNAME OUI_type_distribution' +O$DIR_BASE/distribution-ouitype/analog.html 
	;;

    "combined")
	echo "Multible pie chars not supported by analog - exit"
	exit 1

	if [ ! -f $FILE_TMP ]; then
		# create combined file
		echo "Create combined logfile..."

		echo "addrtype..."
		cat $LOGFILE | $BIN_IPV6LOGCON --out addrtype >$FILE_TMP

		echo "ipv6addrtype..."
		cat $LOGFILE | $BIN_IPV6LOGCON --out ipv6addrtype >>$FILE_TMP
	
		echo "ouitype..."
		cat $LOGFILE | $BIN_IPV6LOGCON --out ouitype >>$FILE_TMP

		echo "...done"
	else
		echo "Combined logfile already exists"
	fi

	echo "Create statistics running 'analog'"
	cat $FILE_TMP | analog +g$CONFIG_ANALOG +C'HOSTNAME combined' +O$DIRBASE/distribution-combined/analog.html 

	;;
    *)
	echo "Usage: $0 dedicated|combined"
esac
