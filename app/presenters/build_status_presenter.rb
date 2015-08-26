class BuildStatusPresenter < Struct.new(:bench)
  delegate :success?, :pending?, to: :bench

  def to_html
    return ht 'div', 'Push to run benchmarks' if bench.nil?

    ht 'div' do |ha|
      ha.('span', "#{small_sha} - #{time_info}", class: "build #{benchmark_status}")
    end
  end

  private

  def small_sha
    bench.commit.sha.slice(0, 6)
  end

  def time_info
    if pending?
      'In progress'
    else
      "#{completed_at} ago"
    end
  end

  def completed_at
    date_helper.time_ago_in_words(bench.completed_at)
  end

  def benchmark_status
    if pending?
      'pending'
    elsif success?
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
