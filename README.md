# kamailio-course

This repo will eventually be connected to a Udemy Course. Check back for more details in the future.

# Branch Definition
  course/01-basic-config = Setting up the inital structure
  course/02-first-refactor = Performing a refactor to start to separate concerns.
  course/03-general-reqs = Building out the General Requirements
  course/04-rtpengine = Setting up RTPEngine to allow Media
  course/05-cdrs =  Call Detail Record Configuration
* course/06-tls = Setting up TLS


# Business Requirements

When building a SIP Proxy, it's important to understand the business requirements. This ensures that you build the right functionality, without overengineering. For this course, we will use the following requirements.

*General*
- The service must be able to differentiate between requests from the Public Side, and the “Core” side.
- Packets are not permitted to travel from the Public Internet to the core without going through the Proxy/SBC.
- All packets that can be seen by external parties must not present the private IPs found within the core.
- The service must respond to external SIP options with a 200 OK (assuming the IP is permitted)
- The service must create call detail records and store them in a database.
- CDRS will contain the time of the call attempt, duration, source #, destination #, remote IP, call ID,
- CDRs will begin counting the duration once the call is connected.
- The service must work with SIP using UDP (port 5060) and TLS (port 5061). TCP on port 5060 must not be permitted.
- The service must offer support for encrypted media (SRTP)

*Inbound*
- The service must have the ability to block IPs if they are potentially malicious
- The service must have the ability to accept registrations from external devices.
- All codecs other that G.711U and G.711A must be removed from INVITE before making it to the core services
- The service must have the ability to distribute inbound calls to multiple core servers using round robin distribution.


*Outbound*
- Outbound requests must use ENUM.
- If multiple records exist AND a request fails, the proxy must try to send the call to the next endpoint in the list within an acceptable time frame.
- If TLS is used, offer SRTP by default.
