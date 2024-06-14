# kamailio-course

This repo is linked to the Udemy Course "Learn SIP Through Kamailio"[https://www.udemy.com/course/learn-sip-through-kamailio/\?referralCode\=1091DEB811F7C7329839].  

# Important 
If you choose to work only from the main branch, and not start with course/01-basic-config, then you will need to run the initial_setup.sh script. This script MUST be called from the directory that it resides in. 

```
git clone https://github.com/keithcroxford/kamailio-course.git
cd kamailio-course
chmod +x initial_setup.sh
./init_setup.sh

```

# Branch Definitions
  - course/01-basic-config = Setting up the inital structure
  - course/02-first-refactor = Performing a refactor to start to separate concerns.
  - course/03-general-reqs = Building out the General Requirements 
  - course/04-rtpengine = Setting up RTPEngine to allow Media
  - course/05-cdrs =  Call Detail Record Configuration
  - course/06-tls = Setting up TLS 
  - course/07-topo = Setting up the topology hiding functionality
  - course/08-registrar = Building a basic SIP Registrar
  - course/09-removing-codecs = Removing codecs from the SDP as a 
  - course/10-secfilter = Demonstrates how traffic can be blocked with Secfilter, Pike and Htable
  - course/11-dispatcher = Load balancing inbound traffic to multiple core B2BUAs
  - course/12-srtp = Shows to to convert RTP -> SRTP and vice versa 
  - course/13-enum = Demonstrates how outbound calls can be routed with ENUM 


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


