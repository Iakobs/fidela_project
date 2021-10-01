extends Control

func load_scene(next_scene):
	SceneChanger.go_to_scene(next_scene, self)
