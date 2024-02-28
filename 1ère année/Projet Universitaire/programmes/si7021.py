import smbus
import time
import math
 
# Bus I2C
bus = smbus.SMBus(1)
bus.write_byte(0x40, 0xF5)
 
time.sleep(0.3)
 
# SI7021 address, 0x40  Read 2 bytes, Humidity
data0 = bus.read_byte(0x40)
data1 = bus.read_byte(0x40)
 
# Convert the data
hum = round(((data0 * 256 + data1) * 125 / 65536.0) - 6)
humrel = hum/100
 
time.sleep(0.3)
bus.write_byte(0x40, 0xF3)
time.sleep(0.3)
 
# SI7021 address, 0x40 Read data 2 bytes, Temperature
data0 = bus.read_byte(0x40)
data1 = bus.read_byte(0x40)
 
# Convert the data and output it
celsTemp = round(((data0 * 256 + data1) * 175.72 / 65536.0) - 46.85)
fahrTemp = round(celsTemp * 1.8 + 32)


#Point de rosée
celsRosee=round((237.7*(((17.27*celsTemp)/(237.7+celsTemp))+math.log(humrel)))/(17.27-(((17.27*celsTemp)/(237.7+celsTemp))+math.log(humrel))),2)
fahrRosee=round((237.7*(((17.27*fahrTemp)/(237.7+fahrTemp))+math.log(humrel)))/(17.27-(((17.27*fahrTemp)/(237.7+fahrTemp))+math.log(humrel))),2)

print ("Humidité : ",hum,"%")
print ("Température : ",celsTemp,"°C")
print ("Température : ",fahrTemp,"°F")
print ("Point de rosée : ",celsRosee,"°C")
print ("Point de rosée : ",fahrRosee,"°F")

import paho.mqtt.publish as publish

publish.single("projet/si7021pi/ctemp", celsTemp, hostname="10.206.0.145")
publish.single("projet/si7021pi/ftemp", fahrTemp, hostname="10.206.0.145")
publish.single("projet/si7021pi/crosee", celsRosee, hostname="10.206.0.145")
publish.single("projet/si7021pi/frosee", fahrRosee, hostname="10.206.0.145")
publish.single("projet/si7021pi/hum", hum, hostname="10.206.0.145")


