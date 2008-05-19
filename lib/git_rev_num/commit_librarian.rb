module GitRevisionNumbers
  class CommitLibrarian
    attr_reader :commits

    def initialize(init_directory=".")
      @repository = Repository.new(init_directory)
      @commits = @repository.commits
    end

    def head_rev_number
      commits.size
    end
    
    def sha1_head
      commits.last
    end
    
    def abbreviated_sha1_head
      sha1_head[0..4]
    end

    def find_commit_by_sha1(hash)
      commits.select { |e| e == hash }
    end

    def find_commit_by_rev_number(number)
      commits[number - 1]
    end
  end
end
