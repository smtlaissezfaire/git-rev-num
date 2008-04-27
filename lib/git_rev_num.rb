# A one off script for mapping
# git SHA1 hashes to global commit numbers
module GitRevisionNumbers
  class Repository

    def initialize(repository_root=".")
      @repository_root = repository_root
    end

    def branches
      %x(git-branch).map { |branch| extract_branch_name(branch) }
    end

    def extract_branch_name(branch_name)
      branch_name.gsub!("\s.+", "")
      branch_name.gsub!("\*", "")
      branch_name.strip
    end

    private :extract_branch_name

    def find_commits
      %x(git-rev-list #{branches.join(" ")})
    end

    def commits
      @commits ||= find_commits.split.reverse
    end
  end

  class CommitLibrarian
    attr_reader :commits

    def initialize
      @repository = Repository.new
      @commits = @repository.commits
    end

    def head_rev
      commits.size + 1
    end

    def find_commit_by_sha1(hash)
      commits.select { |e| e == hash }
    end

    def find_commit_by_rev_number(number)
      commits[number - 1]
    end
  end
end

