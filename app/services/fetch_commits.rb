class FetchCommits
  def call
    repo.commits.each do |commit|
      Commit.where(:sha => commit.sha).first_or_create do |new_commit|
        new_commit.committed_at = commit.date
      end
    end
  end

  private

  def repo
    @repo ||= HelixPiRepo.new
  end
end
