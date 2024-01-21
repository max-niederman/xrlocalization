import socket
import ntcore
import struct

nt = ntcore.NetworkTableInstance.getDefault()
topic = nt.getTable("XRLocalization").getDoubleArrayTopic("Transform")
publisher = topic.publish(ntcore.PubSubOptions(periodic=0.01))

nt.setServer("localhost")
nt.startClient4("XRLocalization")

# Set up the socket for UDP
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('', 6000))

while True:
    data, addr = sock.recvfrom(52)

    mat = struct.unpack("i12f", data)[1:]

    publisher.set(list(mat))