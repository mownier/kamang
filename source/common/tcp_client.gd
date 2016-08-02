
extends Node

signal on_request_error(data)
signal on_receive_data(data)
signal on_update_connection(status)

const STATUS_DISCONNECTED = 0
const STATUS_CONNECTING = 1
const STATUS_CONNECTED = 2
const STATUS_CONNECTION_TIMEOUT = 3
const STATUS_CONNECTION_ERROR = 4

var host
var port
var tcp = StreamPeerTCP.new()

var timeout = 60.0
var timeout_counter = 0.0
var status = STATUS_DISCONNECTED

var data_queue = Array()
var is_processing_data = false

func _init(h, p):
	host = h
	port = p

func _process(delta):
	var tcp_status = tcp.get_status()
	if tcp_status == tcp.STATUS_CONNECTED:
		if status != STATUS_CONNECTED:
			status = STATUS_CONNECTED
			emit_signal("on_update_connection", status)
		
		var bytes = tcp.get_available_bytes()
		if bytes > 0:
			var data = tcp.get_data(bytes)
			emit_signal("on_receive_data", data[1])
		
		var size = data_queue.size()
		if size > 0 and not is_processing_data:
			is_processing_data = true
			var data = data_queue[size - 1]
			var result = send(data)
			if result != OK:
				emit_signal("on_request_error", data)
				stop()
	
	elif tcp_status == tcp.STATUS_CONNECTING:
		if status != STATUS_CONNECTING:
			status = STATUS_CONNECTING
			emit_signal("on_update_connection", status)
		
		timeout_counter += delta
		if timeout_counter > timeout:
			if status != STATUS_CONNECTION_TIMEOUT:
				status = STATUS_CONNECTION_TIMEOUT
				emit_signal("on_update_connection", status)
				timeout_counter = 0
				stop()

func start():
	var err = tcp.connect(host, port)
	if  err != OK:
		status = STATUS_CONNECTION_ERROR
		emit_signal("on_update_connection", status)
	else:
		set_process(true)

func stop():
	tcp.disconnect()
	status = STATUS_DISCONNECTED
	emit_signal("on_update_connection", status)
	set_process(false)
	data_queue.resize(0)
	is_processing_data = false

func send(data):
	var result = FAILED
	if status == STATUS_CONNECTED:
		result = tcp.put_data(data)
	return result

func queue(data):
	var bytes = data.to_utf8()
	data_queue.push_front(bytes)

func dequeue():
	var size = data_queue.size()
	if size > 0:
		data_queue.remove(size - 1)
		if data_queue.size() == 0:
			data_queue.resize(0)
	is_processing_data = false

func get_status():
	return status

func set_timeout(seconds):
	timeout = seconds
