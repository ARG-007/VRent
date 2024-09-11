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


pprint(len(owners))
pprint(len(vehicleModels))

from faker import Faker
from datetime import datetime
drivers = []

for i in range(40):
    name = Faker().name()
    date = datetime.today().isoformat()

    drivers.append({"id": i, "name": name, "joinedOn": date})

print(len(drivers))

with open("drivers.json", 'w') as file:
    json.dump(drivers, file)

