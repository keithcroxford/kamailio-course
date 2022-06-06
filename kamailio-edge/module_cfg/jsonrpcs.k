# ----- jsonrpcs params -----
modparam("jsonrpcs", "pretty_format", 1)
/* set the path to RPC fifo control file */
# modparam("jsonrpcs", "fifo_name", "/run/kamailio/kamailio_rpc.fifo")
/* set the path to RPC unix socket control file */
# modparam("jsonrpcs", "dgram_socket", "/run/kamailio/kamailio_rpc.sock")