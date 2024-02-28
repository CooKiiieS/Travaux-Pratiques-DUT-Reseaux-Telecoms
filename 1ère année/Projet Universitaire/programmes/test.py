import paho.mqtt.client as mqtt #import the client1

client = mqtt.Client("pi") #create new instance
client.connect("192.118.1.214") #connect to broker

client.subscribe("#")

client.publish("projet/sct013/tension",1)

client.publish("projet/si7021a/ctemp",1)
client.publish("projet/si7021a/ftemp",1)
client.publish("projet/si7021a/crosee",1)
client.publish("projet/si7021a/frosee",1)
client.publish("projet/si7021a/hum",1)

client.publish("projet/si7021pi/ctemp",1)
client.publish("projet/si7021pi/ftemp",1)
client.publish("projet/si7021pi/crosee",1)
client.publish("projet/si7021pi/frosee",1)
client.publish("projet/si7021pi/humidite",1)
