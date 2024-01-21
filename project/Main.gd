extends Node3D

var xr_interface: XRInterface

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

func _process(delta):
	print($XROrigin3D/XRCamera3D.global_transform)
