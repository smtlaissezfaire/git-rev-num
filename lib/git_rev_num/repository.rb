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
end