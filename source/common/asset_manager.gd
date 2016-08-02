
extends Node

signal on_request_result(result, id, filepath)

var TCPClient = preload("res://source/common/tcp_client.gd")
var tcp_client
var request_queue = IntArray()
var tmp_file

func _init(host, port):
	tcp_client = TCPClient.new(host, port)
	tcp_client.set_timeout(5)
	tmp_file = str("user://tmp_", OS.get_unix_time())

func _ready():
	tcp_client.connect("on_update_connection", self, "connection_update")
	tcp_client.connect("on_receive_data", self, "data_received")
	tcp_client.connect("on_request_error", self, "error_request")
	add_child(tcp_client)
	tcp_client.start()

func connection_update(status):
	print("status: ", status)
	if (status == tcp_client.STATUS_CONNECTION_ERROR or 
		status == tcp_client.STATUS_CONNECTION_TIMEOUT):
		emit_signal("on_request_result", FAILED, request_queue[0], null)

func data_received(data):
	var size = data.size()
	print("data size: ", size)
	
	if size > 0:
		var file = File.new()
		var err = file.open(tmp_file, File.READ_WRITE)
		if err != OK:
			file.open(tmp_file, File.WRITE)
		file.seek_end()
		file.store_buffer(data)
		
		if file.is_open():
			file.close()
	
	if size > 2 and data[size - 1] == 10 and data[size - 2] == 10:
		request_queue.remove(0)
		if request_queue.size() == 0:
			request_queue.resize(0)
		
		var response = extract_response(data)
		var info = (response.get_string_from_utf8()).split(",", false)
		var id = info[0]
		var name = str("user://", info[1])
		
		tcp_client.dequeue()
		
		var dir = Directory.new()
		var err = dir.open("user://")
		if err == OK:
			if dir.file_exists(tmp_file):
				dir.rename(tmp_file, name)
		
		emit_signal("on_request_result", OK, id, name)

func extract_response(data):
	var response = null
	var i = data.size() - 3
	var start_index = -1
	var end_index = i
	while true:
		if i < 1:
			break
		if data[i] == 10 and data[i - 1] == 13:
			start_index = i + 1
			break
		i -= 1
	
	if start_index > -1 and end_index > 0:
		response = RawArray()
		i = start_index
		while i < end_index + 1:
			response.append(data[i])
			i += 1
	
	return response

func error_request(data):
	var info = (data.get_string_from_utf8()).split(",")
	var name = data[0]
	var id = data[1]
	emit_signal("on_request_result", FAILED, id, name)

func request_asset(name):
	var id = OS.get_unix_time()
	request_queue.append(id)
	var data = str(name, ",", id, ",\n")
	tcp_client.queue(data)
	return id
