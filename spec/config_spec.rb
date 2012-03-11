require "spec_helper"

describe Gitosis::Config do

	describe "Initializing the gitosis config" do

		it "should raise an error for an invalid path" do
			lambda {Gitosis::Config.new_from_repository(
				"/some/none/existing/path")}.should raise_error
		end

		it "should raise an error for an invalid INI file" do
			lambda {Gitosis::Config.new_from_repository(
						"spec/repo2")}.should raise_error
		end

		it "should load a valid INI file" do
			config = Gitosis::Config.new_from_repository("spec/repo1")
			config.should be_an_instance_of(Gitosis::Config)
		end
	end

	describe "Parsing the gitosis config" do

		before do
			@config = Gitosis::Config.new_from_repository("spec/repo1")
		end

		it "should return a config file" do
			@config.data.should_not == nil
		end

		it "should return all defined groups" do
			@config.groups.count.should == 3
			@config.groups[0].name.should == "group1"
			@config.groups[1].name.should == "group2"
			@config.groups[2].name.should == "group3"
		end

		it "should return all defined groups" do
			@config.groups.count.should == 3
			@config.groups[0].members.should == ["member1", "member2", "member3"]
		end
	end
end
