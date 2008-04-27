require File.dirname(__FILE__) + "/../spec_helper"

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