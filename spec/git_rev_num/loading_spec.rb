require File.dirname(__FILE__) + "/../spec_helper"

# it should not raise an error when loading...

describe GitRevisionNumbers do
  it "should have the CommitLibrarian" do
    lambda {
      GitRevisionNumbers::CommitLibrarian
    }.should_not raise_error
  end
  
  it "should have the MasterCommitLibrarian" do
    lambda {
      GitRevisionNumbers::MasterCommitLibrarian
    }
  end
end