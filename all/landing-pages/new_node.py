import sys
import json

new_node_json=sys.argv[1]
new_node=json.loads(new_node_json)
print(new_node["nid"][0]["value"])
