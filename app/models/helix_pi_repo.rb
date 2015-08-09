class HelixPiRepo
  def clone
    `git clone https://github.com/Widdershin/helix-pi.git`
  end

  def fetch
    clone

    Dir.chdir 'helix-pi' do
      `git fetch`
    end
  end
end
