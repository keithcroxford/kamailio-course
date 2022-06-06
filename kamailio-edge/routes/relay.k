# Wrapper for relaying requests
route[RELAY] {

	# enable additional event routes for forwarded requests
	# - serial forking, RTP relaying handling, a.s.o.
	if (is_method("INVITE|BYE|SUBSCRIBE|UPDATE")) {
		if(!t_is_set("branch_route")) t_on_branch("MANAGE_BRANCH");
	}
	if (is_method("INVITE|SUBSCRIBE|UPDATE")) {
		if(!t_is_set("onreply_route")) t_on_reply("MANAGE_REPLY");
	}
	if (is_method("INVITE")) {
		if(!t_is_set("failure_route")) t_on_failure("MANAGE_FAILURE");
	}

	if (!t_relay()) {
		sl_reply_error();
	}
	exit;
}
