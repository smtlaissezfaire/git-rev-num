module GitRevisionNumbers
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
end