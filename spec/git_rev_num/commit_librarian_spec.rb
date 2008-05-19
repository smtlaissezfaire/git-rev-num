require File.dirname(__FILE__) + "/../spec_helper"

module GitRevisionNumbers
  describe CommitLibrarian do
    before :each do
      @repository = mock(Repository, :commits => nil)
      Repository.stub!(:new).and_return @repository
    end

    it "should initialize with a repository root" do
      Repository.should_receive(:new).with("foo").and_return @repository
      CommitLibrarian.new("foo")
    end
    
    it "should initialize with a default repository root" do
      Repository.should_receive(:new).with(".").and_return @repository
      CommitLibrarian.new
    end
    
    describe "commit numbers" do
      before :each do
        @repository.stub!(:commits).and_return ["0a123", "0a234"]
        @librarian = CommitLibrarian.new()
      end
      
      it "should find the proper head revision number" do
        @librarian.head_rev_number.should == 2
      end
    end
  end
end
