class HelixPiRepo
  def commits
    repo.log.since('2 weeks ago')
  end

  def setup
    Dir.chdir 'helix-pi' do
      `git checkout master`
      `git fetch`
      `npm install`
    end
  end

  def checkout(hash)
    Dir.chdir 'helix-pi' do
      `git checkout #{hash} -- .`


      helix_pi_lines = File.readlines('helix.js')

      if helix_pi_lines.first.include? 'babel'
        helix_pi_lines.shift
        File.write('helix.js', helix_pi_lines.join("\n"))
      end
    end
  end

  def repo
    @repo ||= Git.open('./helix-pi', :log => Logger.new(STDOUT)) if File.directory?('./helix-pi/.git')
    @repo ||= Git.clone('https://github.com/Widdershin/helix-pi.git', 'helix-pi')
  end
end
