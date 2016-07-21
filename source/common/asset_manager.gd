
extends Reference

var host
var port
var connection = StreamPeerTCP.new()

func _init(host, port):
	self.host = host
	self.port = port

func open():
	return connection.connect(host, port)

func close():
	connection.disconnect()


