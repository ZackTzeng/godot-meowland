extends Node


func load_json_into_dict(json_file_path) -> Dictionary:
	var f = FileAccess.open(json_file_path, FileAccess.READ)
	var json_dict = JSON.parse_string(f.get_as_text())
	f.close()
	return json_dict
	
	
func save_dict_to_json(_dict, json_file_path):
	var f = FileAccess.open(json_file_path, FileAccess.WRITE)
	f.store_line(JSON.stringify(_dict, "\t", true))
