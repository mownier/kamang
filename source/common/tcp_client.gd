
extends Node

signal on_receive_data(data)
signal on_update_connection(status)

const CONNECTION_OK = 0
const CONNECTION_FAIL = 1
const CONNECTION_DROP = 2
const CONNECTION_TIMEOUT = 3
const CONNECTION_RESOLVING = 4
const CONNECTION_NONE = 5

const STATUS_CONNECTED = 6
const STATUS_NONE = 7

var host
var port
var tcp = StreamPeerTCP.new()

var timeout = 60.0
var timeout_counter = 0.0
var conn_status = CONNECTION_NONE

func _init(h, p):
	host = h
	port = p

func _process(delta):
	var status = tcp.get_status()
	if status == tcp.STATUS_CONNECTED:
		if conn_status != CONNECTION_OK:
			conn_status = CONNECTION_OK
			emit_signal("on_update_connection", conn_status)
		
		var bytes = tcp.get_available_bytes()
		if bytes > 0:
			var data = tcp.get_data(bytes)
			emit_signal("on_receive_data", data[1])
		
	elif status == tcp.STATUS_CONNECTING:
		if conn_status != CONNECTION_RESOLVING:
			conn_status = CONNECTION_RESOLVING
			emit_signal("on_update_connection", conn_status)
		
		timeout_counter += delta
		if timeout_counter > timeout:
			if conn_status != CONNECTION_TIMEOUT:
				conn_status = CONNECTION_TIMEOUT
				emit_signal("on_update_connection", conn_status)
				timeout_counter = 0

func start():
	var err = tcp.connect(host, port)
	if  err != OK:
		conn_status = CONNECTION_FAIL
		emit_signal("on_update_connection", conn_status)
	else:
		set_process(true)

func stop():
	tcp.disconnect()
	conn_status = CONNECTION_DROP
	emit_signal("on_update_connection", conn_status)
	set_process(false)

func send(data):
	var result = FAILED
	if conn_status == CONNECTION_OK:
		result = tcp.put_data(var2bytes(data))
	if result != OK:
		stop()
	return result

func get_connection_status():
	return conn_status

func set_timeout(seconds):
	timeout = seconds
