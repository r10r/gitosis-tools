def self.notify title, msg, img
	system "notify-send '#{title}' '#{msg}' -i #{img} -t 3000"
end

def run(files_to_run)
	image_root = "/usr/share/icons/gnome/48x48/emotes"
	puts("Running: #{files_to_run}")
	results=`rspec -f h -o /tmp/rspec.html #{files_to_run}`

	rspec_result = $?

	if rspec_result == 0
		notify "Cool", "all tests pass", "#{image_root}/face-cool.png"
	else
		`chromium /tmp/rspec.html`
	end
end

watch("spec/.*/*_spec.rb") do |match|
	run match[0]
end

watch("lib/(.*)/(.*).rb") do |match|
	spec_file = "spec/#{match[2]}_spec.rb"
	run spec_file if File.exist? spec_file
end