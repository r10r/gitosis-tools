require 'inifile'

class Gitosis::Config

	# @param path [String] the path to the gitosis admin repository
	def self.new_from_repository(path)
		repository_path = path
		config = File.join(path, "gitosis.conf")
		if not File.exist? config
			raise "Gitosis config #{config} does not exist."
		end

		# load data from inifile
		data = IniFile.load(config)

		Gitosis::Config.new(path, data)
	end

	attr_accessor :path, :data, :groups

private

	def initialize(path, data)
		@path = path
		@data = data
		@groups = []

		parse_data()
	end

	def parse_data
		@data.each_section do |section|
			if section == "gitosis"
				parse_global_section
			elsif section.start_with? "group "
				parse_group(section)
			end
		end
	end

	def parse_global_section

	end

	def parse_group(header)
		name = header.gsub(/^group /, "")
		data = @data[header]
		groups << Gitosis::Group.new(name, data)
	end

end
