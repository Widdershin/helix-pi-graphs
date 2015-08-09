class BuildStatusPresenter < Struct.new(:bench)
  delegate :created_at, :success?, :to => :bench

  def to_html
    return ht 'div', 'Push to run benchmarks' if bench.nil?

    ht 'div' do |ha|
      ha.('span', 'Last run: ')
      ha.('span', "#{small_sha} - #{created_at} ago", class: "build #{benchmark_status}")
    end
  end

  private

  def small_sha
    bench.commit.sha.slice(0, 6)
  end

  def created_at
    date_helper.time_ago_in_words(bench.created_at)
  end

  def benchmark_status
    if success?
      'passing'
    else
      'failing'
    end
  end

  def ht(*args)
    return html_helper.content_tag(*args) unless block_given?

    html_helper.content_tag(*args) do
      children = []

      yield(-> (*innerArgs, &block) {
        children << ht(*innerArgs, &block)
      })

      children.sum
    end
  end

  def html_helper
    @html_helper ||= ActionView::Base.new.extend(ActionView::Helpers::TagHelper)
  end

  def date_helper
    @date_helper ||= ActionView::Base.new.extend(ActionView::Helpers::DateHelper)
  end
end
