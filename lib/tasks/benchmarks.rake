require 'benchmark'

namespace :benchmark do
  task :leaderboard do |task, args|
    n = 500
    Benchmark.bm do |x|
      x.report do
        n.times { User.first.total_score }
      end
    end
  end
end
