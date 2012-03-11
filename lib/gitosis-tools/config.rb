class Gitosis::Config
	# @param path [String] the path to the gitosis admin repository
	def new_from_repository(path)
		@repository_path = path
	end

	def get_repositories
		"puts yeah"
	end

end
