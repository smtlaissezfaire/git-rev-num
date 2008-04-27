module GitRevisionNumbers
  class MasterCommitLibrarian < CommitLibrarian
    def initialize
      super
      @commits = @repository.commits(:master)
    end
  end
end

