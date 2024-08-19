import json
from pprint import pprint

fileContents = {}

with open("vehicles.json") as file:
    fileContents = json.load(file)

pprint(fileContents[0])

owners = [vehicle["owner"] for vehicle in fileContents]

pprint(owners[0])

vehicleModels = [vehicle["spec"] for vehicle in fileContents]

pprint(vehicleModels[0])

for vehicle in fileContents:
    vehicle["owner"] = vehicle["owner"]["id"]
    vehicle["spec"] = vehicle["spec"]["id"]

owners = list(set(owners))
vehicleModels = list(set(vehicleModels))

pprint(len(owners))
pprint(len(vehicleModels))



