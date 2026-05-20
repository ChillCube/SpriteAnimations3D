extends Resource
class_name SpriteAnimations3D

## This is a collection of function used for animating sprites

static func speechwobble(delta: float, sprite : Sprite3D, is_moving: bool, target_scale : float, squash : float): ## Squash-and-stretch bob: rhythmic stepping when moving, smooth return when idle
	var time = Time.get_ticks_msec() * 0.001
	
	if is_moving:
		# Using abs(sin) creates a rhythmic "stepping" motion
		var bounce = abs(sin(time * 20.0)) 
		
		sprite.scale.y = lerp(sprite.scale.y, target_scale - (bounce * squash), delta * 20)
		sprite.scale.x = lerp(sprite.scale.x, target_scale + (bounce * squash), delta * 20)
		
	else:
		# Smoothly brings the sprite back to its original shape when stopped
		sprite.scale = sprite.scale.lerp(Vector3(target_scale, target_scale, target_scale), delta * 10.0)

static func idle_sway(delta: float, sprite: Sprite3D, camera: Camera3D, base_scale: Vector3, is_idle: bool = true): ## Billboard sway with layered jitter, breathing bob, and subtle squash-stretch for idle NPCs
	# Using a unique offset (like the sprite's ID) so multiple NPCs don't move in sync
	var time = (Time.get_ticks_msec() * 0.001) + (sprite.get_instance_id() * 0.1)
	
	if is_idle and camera:
		# 1. Faster Billboard Alignment
		sprite.rotation.y = lerp_angle(sprite.rotation.y, camera.rotation.y, delta * 12.0)

		# 2. Layered Sway (Organic jitter)
		var primary_sway = sin(time * 1.5) * deg_to_rad(3.0)
		var micro_jitter = sin(time * 5.0) * deg_to_rad(0.5) 
		var total_sway = primary_sway + micro_jitter
		sprite.rotation.z = lerp(sprite.rotation.z, total_sway, delta * 4.0)
		
		# 3. Breathing Bob
		var breathing = cos(time * 1.2) * 0.05
		sprite.position.y = lerp(sprite.position.y, breathing, delta * 3.0)

		# 4. Relative Squash and Stretch
		# We multiply the 'pulse' against the original base_scale dimensions
		var pulse = 1.0 + (sin(time * 1.2) * 0.02)
		sprite.scale.x = lerp(sprite.scale.x, base_scale.x * pulse, delta * 2.0)
		sprite.scale.y = lerp(sprite.scale.y, base_scale.y * (1.0 / pulse), delta * 2.0)
		sprite.scale.z = base_scale.z # Keep Z constant
		
	else:
		# Return to the specific base_scale rather than 1.0
		sprite.rotation.z = lerp(sprite.rotation.z, 0.0, delta * 5.0)
		sprite.position.y = lerp(sprite.position.y, 0.0, delta * 5.0)
		sprite.scale = sprite.scale.lerp(base_scale, delta * 5.0)
static func walk_wobble(delta: float, sprite: Sprite3D, camera: Camera3D, is_moving: bool, max_rotation_deg: float = 8.0, speed: float = 12.0, bob_height: float = 0.15): ## Side-to-side tilt and vertical bob while moving; resets to neutral when stopped
	var time = Time.get_ticks_msec() * 0.001
	
	# 1. Face the camera (Billboard alignment)
	if camera:
		sprite.rotation.y = lerp_angle(sprite.rotation.y, camera.rotation.y, delta * 15.0)

	if is_moving:
		# 2. Side-to-side Tilt (The Wobble)
		# We use sin(time) for a smooth left-to-right oscillation
		var sway_rad = sin(time * speed) * deg_to_rad(max_rotation_deg)
		sprite.rotation.z = lerp(sprite.rotation.z, sway_rad, delta * 10.0)
		
		# 3. Vertical Bobbing (The Step)
		# Using abs(sin) creates a "bouncing" effect rather than a smooth float
		var bob = abs(sin(time * speed)) * bob_height
		sprite.position.y = lerp(sprite.position.y, bob, delta * 10.0)
		
	else:
		# 4. Reset to Neutral when stopped
		sprite.rotation.z = lerp(sprite.rotation.z, 0.0, delta * 5.0)
		sprite.position.y = lerp(sprite.position.y, 0.0, delta * 5.0)
		
static func talk_chatter(delta: float, sprite: Sprite3D, camera: Camera3D, base_scale: Vector3, is_talking: bool = true): ## Rapid squash-stretch chatter with emphatic sway and jaw-bob for talking NPCs
	# Unique offset so multiple talkers don't sync up
	var time = (Time.get_ticks_msec() * 0.001) + (sprite.get_instance_id() * 0.5)
	
	if is_talking and camera:
		# 1. Faster, more "attentive" billboard alignment
		sprite.rotation.y = lerp_angle(sprite.rotation.y, camera.rotation.y, delta * 15.0)

		# 2. Emphatic Sway (Faster and slightly wider than idle)
		# We mix two fast sine waves to make the "bobbing" look less predictable
		var talk_sway = (sin(time * 8.0) * 0.5 + sin(time * 3.2)) * deg_to_rad(4.0)
		sprite.rotation.z = lerp(sprite.rotation.z, talk_sway, delta * 8.0)
		
		# 3. Vertical "Chatter" (Simulating jaw/body movement)
		# We use a very fast sine wave for the Y-position
		var chatter_bob = abs(sin(time * 12.0)) * 0.08
		sprite.position.y = lerp(sprite.position.y, chatter_bob, delta * 10.0)

		# 4. Rapid Squash & Stretch (The "Talking" mouth feel)
		# Talking usually involves rapid vertical stretching
		var talk_pulse = 1.0 + (sin(time * 15.0) * 0.04)
		sprite.scale.x = lerp(sprite.scale.x, base_scale.x * (1.0 / talk_pulse), delta * 15.0)
		sprite.scale.y = lerp(sprite.scale.y, base_scale.y * talk_pulse, delta * 15.0)
		
	else:
		# Smoothly return to the base state when they stop talking
		sprite.rotation.z = lerp(sprite.rotation.z, 0.0, delta * 5.0)
		sprite.position.y = lerp(sprite.position.y, 0.0, delta * 5.0)
		sprite.scale = sprite.scale.lerp(base_scale, delta * 5.0)

