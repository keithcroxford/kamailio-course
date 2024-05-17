# Example ENUM / NAPTR Entry

A NAPTR entry for the phone number +31201234567 would looke like this. Notice that the numbers ir reversed in the e164.arpa entry! 

```
7.6.5.4.3.2.1.0.2.1.3.e164.arpa. 300  IN NAPTR 100 10 "u" "E2U+SIP" "!^.*$!sip:31201234567@sip.example.com!" .
```

Explanation of the NAPTR Entry Components: 
* Order: 100 - Determines the order of processing. 
* Preference: 10 - Sets the preference level among entries with the same order. 
* Flags: "u" - Indicates that the output is a URI. 
* Service: "E2U+SIP" - Specifies the ENUM service and that it maps to a SIP URI. 
* Regexp: "!^.*$!sip:31201234567@sip.example.com!" - A regular expression that translates the phone number into the corresponding SIP URI. 
* Replacement: . - Indicates that no further NAPTR records need to be processed for this query. 

You can perform a dig like this `dig @127.0.0.1 -p 53 NAPTR 7.6.5.4.3.2.1.0.2.1.3.e164.arpa`

---
```mermaid
sequenceDiagram
    participant User
    participant VoIP System
    participant ENUM DNS
    participant VoIP Destination

    User->>VoIP System: Dials traditional phone number
    VoIP System->>ENUM DNS: Sends ENUM query (phone number with ENUM domain)
    ENUM DNS->>VoIP System: Returns NAPTR records with URIs
    VoIP System->>VoIP Destination: Routes call to SIP URI
    VoIP Destination->>User: Call connected