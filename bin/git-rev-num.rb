#!/usr/bin/env ruby

revision_number = ARGV[0]

if revision_number
  require File.dirname(__FILE__) + "/../lib/git_rev_num"

  librarian = GitRevisionNumbers::CommitLibrarian.new
  puts librarian.find_commit_by_rev_number(revision_number.to_i)
else
  puts ""
  puts "USAGE: git_rev_num sequential-revision-number"
  puts ""
end
