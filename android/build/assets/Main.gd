extends Node3D

var xr_interface: XRInterface
var proxy_conn: PacketPeer

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		
		# enable passthrough, if available
		if xr_interface.is_passthrough_supported():
			xr_interface.start_passthrough()
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
	proxy_conn = PacketPeerUDP.new()
	proxy_conn.set_dest_address("192.168.0.159", 6000)

func _process(delta):
	var transform = $XROrigin3D/XRCamera3D.global_transform
	
	if proxy_conn.put_var(transform) != OK:
		print("Failed to send transform to proxy.")
	else:
		print("Sent transform.")
