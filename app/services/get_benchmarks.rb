class GetBenchmarks
  def call
    Dir.glob('benchmarks/*')
  end
end
