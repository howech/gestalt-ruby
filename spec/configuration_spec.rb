require 'spec_helper'

describe GestaltRuby::Configuration do
  before :each do
    @configuration = GestaltRuby::Configuration.new()
  end

  describe "#new" do
    it "returns a configuration object" do
      @configuration.should be_an_instance_of GestaltRuby::Configuration
    end
  end

  describe "#get" do
    it "returns nil for a new name" do
      @configuration.get("a").should eql nil
    end
    
    it "returns nil for a new path" do
      @configuration.get("a:b:c").should eql nil
    end

    it "returns nil for a new array path" do
      @configuration.get(["a","b","c"]).should eql nil
    end
  end

  describe "#set" do
    it "can set a new value" do
      @configuration.set("a","value")
      @configuration.get("a").should eql "value"
    end

    it "can set a new value for a path" do
      @configuration.set("a:b:c","value")
      @configuration.get("a:b:c").should eql "value"
      @configuration.get("a").should be_an_instance_of GestaltRuby::Configuration
      @configuration.get("a:b").should be_an_instance_of GestaltRuby::Configuration
      @configuration.get(["a"]).should be_an_instance_of GestaltRuby::Configuration
      @configuration.get(["a","b"]).should be_an_instance_of GestaltRuby::Configuration
      @configuration.get(["a","b","c"]).should eql "value"
    end

    it "can also set a source" do
      @configuration.set("b","x","source")
      @configuration.getValSource("b")[:value].should eql "x"
      @configuration.getValSource("b")[:source].should eql "source"
    end

    it "can set a source on a path" do
      @configuration.set("c:b:a","value","source")
      @configuration.getValSource("c:b:a")[:value].should eql "value"
      @configuration.getValSource("c:b:a")[:source].should eql "source"
      @configuration.getValSource(["c","b","a"])[:value].should eql "value"
      @configuration.getValSource(["c","b","a"])[:source].should eql "source"
    end
  end
end
