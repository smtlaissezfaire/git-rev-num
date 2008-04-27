module GitRevisionNumbers
  class MasterCommitLibrarian < CommitLibrarian
    def initialize(init_directory=".")
      super
      @commits = @repository.commits(:master)
    end
  end
end
