/*
 * Project    : ipv6calc
 * File       : librfc1884.h
 * Version    : $Id: librfc1884.h,v 1.1 2002/03/18 19:59:24 peter Exp $
 * Copyright  : 2001-2002 by Peter Bieringer <pb (at) bieringer.de>
 *
 * Information:
 *  Header file for librfc1884.c
 */ 

#include "libipv6addr.h"

/* prototypes */
extern int compaddr_to_uncompaddr(const char *addrstring, char *resultstring);

extern int librfc1884_ipv6addrstruct_to_compaddr(const ipv6calc_ipv6addr *ipv6addrp, char *resultstring, const unsigned int formatoptions);
extern int ipv6addrstruct_to_compaddr(const ipv6calc_ipv6addr *ipv6addr, char *resultstring); /* going obsolete */