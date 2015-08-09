class FetchCommits
  def call
    repo.commits.each do |commit|
      Commit.where(:sha => commit.sha).first_or_create
    end
  end

  private

  def repo
    @repo ||= HelixPiRepo.new
  end
end
