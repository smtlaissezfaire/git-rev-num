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
      
      it "should have the proper sha1 head" do
        @librarian.sha1_head.should == "0a234"
      end
      
      it "should have the sha1 head as the last of the repository commits" do
        @repository.stub!(:commits).and_return ["3f3ff"]
        @librarian = CommitLibrarian.new
        @librarian.sha1_head.should == "3f3ff"
      end
      
      it "should have the abbreviated sha1 head as a 5 char string" do
        @repository.stub!(:commits).and_return ["fd110852882a0de37abe6416a149e1e86cc7a13a"]
        @librarian = CommitLibrarian.new
        @librarian.abbreviated_sha1_head.should == "fd110"
      end
    end
  end
end
