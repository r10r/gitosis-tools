class Gitosis::Group

	attr_accessor :name, :writable, :members

	def initialize(name, data)
		@name = name
		@writable = data["writable"].split(" ")
		@members = data["members"].split(" ")
	end

	def get_members
		return @members
	end

end