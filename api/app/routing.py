from flask import Flask, request, jsonify

app = Flask(__name__)

ROUTE1 =  {
    "uri": "sip:b2bua_internal@172.16.254.101:5060",
    "dst_uri": "sip:172.16.254.101:5060",
    "path": "<sip:172.16.254.101:5060>",
    "socket": "udp:172.16.254.2:5060",
    "headers": {
        "from": {
            "display": "Alice",
            "uri": "sip:alice@a.example.org"
        },
        "to": {
            "display": "Bob",
            "uri": "sip:bob@b.example.org"
        },
        "extra": "X-Hdr-A: abc\r\nX-Hdr-B: bcd\r\n"
    },
    "branch_flags": 8,
    "fr_timer": 5000,
    "fr_inv_timer": 30000
}

ROUTE2 =  {
    "uri": "sip:bob@b.example.org:5060",
    "dst_uri": "sip:192.0.2.1:5060",
    "path": "<sip:192.0.2.2:5084>, <sip:192.0.2.2:5086>",
    "socket": "udp:192.0.2.20:5060",
    "headers": {
        "from": {
            "display": "Alice",
            "uri": "sip:alice@a.example.org"
        },
        "to": {
            "display": "Bob",
            "uri": "sip:bob@b.example.org"
        },
        "extra": "X-Hdr-A: abc\r\nX-Hdr-B: bcd\r\n"
    },
    "branch_flags": 8,
    "fr_timer": 5000,
    "fr_inv_timer": 30000
}

ROUTES = [
    ROUTE1, ROUTE2
]


@app.route('/api/routing', methods=['POST'])
def rtjson():
    """
    Extremely simplified API that expects a POST request containing the "from_user" param. 
    Depending on the value, a different list of routes will be provided in the response
    """
    data = request.json  #

    if data['from_user'] == "b2bua_external":
        response_data = {
            "rtjson" : {
                "from_user": data['from_user'],
                "version": "1.0",
                "routing" : "serial",
                "routes" : [ROUTE1], 
            }
        }
        return jsonify(response_data)
    
    if data['from_user'] == "b2bua_internal":
        response_data = {
            "rtjson" : {
                "from_user": data['from_user'],
                "version": "1.0",
                "routing" : "serial",
                "routes" : [ROUTE2], 
            }
        }
        return jsonify(response_data)
    else:
        response_data = {
            "rtjson" : {
                "from_user": data['from_user'],
                "version": "1.0",
                "routing" : "serial",
                "routes" : [], 
            }
        }  
        return jsonify(response_data)

if __name__ == '__main__':
    app.run()