class GetBenchmarks
  def call
    Dir.glob('node_modules/helix-pi-benchmarks/benchmarks/*')
  end
end
