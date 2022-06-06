/* Main SIP request routing logic
 * - processing of any incoming SIP request starts with this route
 * - note: this is the same as route { ... } */
request_route {

	# per request initial checks
	route(REQINIT);

	# CANCEL processing
	if (is_method("CANCEL")) {
		if (t_check_trans()) {
			route(RELAY);
		}
		exit;
	}

	# handle retransmissions
	if (!is_method("ACK")) {
		if(t_precheck_trans()) {
			t_check_trans();
			exit;
		}
		t_check_trans();
	}

	# handle requests within SIP dialogs
	route(WITHINDLG);

	### only initial requests (no To tag)

	# record routing for dialog forming requests (in case they are routed)
	# - remove preloaded route headers
	remove_hf("Route");
	if (is_method("INVITE|SUBSCRIBE")) {
		record_route();
	}

	# account only INVITEs
	if (is_method("INVITE")) {
		setflag(FLT_ACC); # do accounting
	}

	if ($rU==$null) {
		# request with no Username in RURI
		sl_send_reply("484","Address Incomplete");
		exit;
	}

	# update $du to set the destination address for proxying
	$du = "sip:" + $rd + ":9";
	route(RELAY);
	exit;
}