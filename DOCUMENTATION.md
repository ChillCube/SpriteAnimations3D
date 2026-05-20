# SpriteAnimations3D API Reference
Generated: 2026-05-20

A set of animations that can be used on 3D sprites

## Class: SpriteAnimations3D
**Inherits:** [Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html)


### 🛠️ Methods
| Method | Arguments | Returns | Description |
| :--- | :--- | :--- | :--- |
| **()** | - | `void` |  This is a collection of function used for animating sprites |
| **static func speechwobble()** | `delta: float`<br>`sprite : Sprite3D`<br>`is_moving: bool`<br>`target_scale : float`<br>`squash : float` | `void` |  Squash-and-stretch bob: rhythmic stepping when moving, smooth return when idle |
| **static func idle_sway()** | `delta: float`<br>`sprite: Sprite3D`<br>`camera: Camera3D`<br>`base_scale: Vector3`<br>`is_idle: bool = true` | `void` |  Billboard sway with layered jitter, breathing bob, and subtle squash-stretch for idle NPCs |
| **static func walk_wobble()** | `delta: float`<br>`sprite: Sprite3D`<br>`camera: Camera3D`<br>`is_moving: bool`<br>`max_rotation_deg: float = 8.0`<br>`speed: float = 12.0`<br>`bob_height: float = 0.15` | `void` |  Side-to-side tilt and vertical bob while moving; resets to neutral when stopped |
| **static func talk_chatter()** | `delta: float`<br>`sprite: Sprite3D`<br>`camera: Camera3D`<br>`base_scale: Vector3`<br>`is_talking: bool = true` | `void` |  Rapid squash-stretch chatter with emphatic sway and jaw-bob for talking NPCs |

---

