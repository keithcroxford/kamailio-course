# Kamailio with the RTJSON Module and a REST API

The RTJSON module is (in my opinion) the most powerful routing module available for Kamailio. This module enables the ability to parse JSON documents, and make routing decisions based on several key, value pairs present in the JSON structure. When used with the UAC module, you can even perform manipulations on the From and To headers. 

# Dependencies
We need to load several Kamailio modules to experiment with RTJSON Routing.

## RTJSON Module 
Within `/etc/kamailio/modules/rtjson.cfg` we load the rtjson.so module. Loading this module will also define an XAVP that will be used internally by the module. Y 

## JANSSON Module 
In `/etc/kamailio/modules/jansson.cfg` the jansson module is loaded. This module provides operations on JSON strings using the Jansson library. 

## HTTP ASYNC Module 
To make the HTTP calls to the API we use the HTTP ASYNC module which is defined in `/etc/kamailio/modules/http_async_client.cfg`. The benefit of using the HTTP ASYNC library is that we can suspend the transaction, and allow Kamailio to continue processing other requests while we wait for the API Server to send a response. 

We define two params under this module.  

```
modparam("http_async_client", "workers", 2) # how many worker processess to start
modparam("http_async_client", "connection_timeout", 1000) # wait 1000ms / 1s before timing out
``` 

## UAC Module 
`/etc/kamailio/modules/uac.cfg` is where we import the UAC module. This one... has several params to define

```
# Format is modparam(MODULE_NAME, PARAM_NAME, PARAM_VALUE

# Store the original 'From' header URI in a custom AVP (attribute-value pair) before the request is modified
modparam("uac", "rr_from_store_param", "my_param")

# Store the original 'To' header URI in a custom AVP (attribute-value pair) before the request is modified
modparam("uac", "rr_to_store_param", "my_param")

# Automatically restore 'From' and 'To' URIs and headers when handling replies
modparam("uac", "restore_mode", "auto")

# Enable dialog restoration mode, useful for restoring dialog states from stored data
modparam("uac", "restore_dlg", 1)

# Set a secret password for securing the restoration process. In production, keep the password outside of the config. 
modparam("uac", "restore_passwd", "my_secret_passwd")

# Specify the AVP to use for storing the original 'From' URI before modification
modparam("uac", "restore_from_avp", "$avp(original_uri_from)")

# Specify the AVP to use for storing the original 'To' URI before modification
modparam("uac", "restore_to_avp", "$avp(original_uri_to)")
```

## Building a Rest API 
If you want to experience the real power and flexibility of this module, you need a REST API that can be queried when a routing decision must be made. Building a proper API is not within the scope of this course, however we can build a very simple REST API using Python with the Flask library. I've created a extremely simple API located in the api folder.

The logic on this is extremely simple. There's no TLS, no service level auth, etc. It's just an API that will process a POST message, and expects the body to contain a param named "to_user". An example of a curl request to the API is:

```
curl -X POST http://localhost:5000/api/routing \
  -H "Content-Type: application/json" \
  -d '{"to_user": "b2bua_internal"}'
```

Based on the value of to_user, a different set of routes is loaded by the API, and return as a JSON response. 

# Kamailio-Config 
In order to not change much of the existing code, the use of the rtjson fucntionality is essentially "feature flagged" in kamailio.cfg with the line `#!define RTJSON_INBOUND`. You will see references in other files (modules.cfg, routes.cfg) where a check if performed to see if this value was defined. 

The magic happens in `handle_http_request.cfg` and `handle_http_response.cfg`. This is further explained in the video. 





