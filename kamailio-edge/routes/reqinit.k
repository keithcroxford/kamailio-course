# Per SIP request initial checks
route[REQINIT] {
	if($ua =~ "friendly-scanner|sipcli|VaxSIPUserAgent") {
		# silent drop for scanners - uncomment next line if want to reply
		# sl_send_reply("200", "OK");
		exit;
	}

	if (!mf_process_maxfwd_header("10")) {
		sl_send_reply("483","Too Many Hops");
		exit;
	}

	if(is_method("OPTIONS") && uri==myself && $rU==$null) {
		sl_send_reply("200","Keepalive");
		exit;
	}

	if(!sanity_check("1511", "7")) {
		xlog("Malformed SIP message from $si:$sp\n");
		exit;
	}
}