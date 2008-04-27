# A one off script for mapping
# git SHA1 hashes to global commit numbers
module GitRevisionNumbers
  class Repository
    def initialize(repository_root=".")
      @repository_root = repository_root
    end

    attr_reader :repository_root

    def branches
      %x(cd #{repository_root}; git-branch).map { |branch| extract_branch_name(branch) }
    end

    def extract_branch_name(branch_name)
      branch_name.gsub!("\s.+", "")
      branch_name.gsub!("\*", "")
      branch_name.strip
    end

    private :extract_branch_name

    def find_commits(branch_name=nil)
      branch_name ?  rev_list(branch_name) : rev_list_all_branches
    end

    def commits(branch_name=nil)
      commits = branch_name ? find_commits(branch_name) : find_commits
      @commits = commits.split.reverse
    end

  private

    def rev_list(branch_name)
      %x(cd #{repository_root}; git-rev-list #{branch_name} --)
    end

    def rev_list_all_branches
      %x(cd #{repository_root}; git-rev-list #{branches.join(" ")} --)
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

    def find_commit_by_sha1(hash)
      commits.select { |e| e == hash }
    end

    def find_commit_by_rev_number(number)
      commits[number - 1]
    end
  end

  class MasterCommitLibrarian < CommitLibrarian
    def initialize
      super
      @commits = @repository.commits(:master)
    end
  end
end

