local p = import '../params.libsonnet';
local params = p.components.front;
[
  {
     "apiVersion": "v1",
     "kind": "Endpoints",
     "metadata": {
        "name": "prodenp",
     },
     "subsets": [
        {
           "addresses": [
              {
                 "ip": p.components.endpoint.address
              }
           ],
           "ports": [
              {
                 "port": params.service.port,
                 "name": "web"
              }
           ]
        }
     ]
  }
]
