require 'benchmark'

namespace :benchmark do
  task :leaderboard do |task, args|
    n = 50
    Benchmark.bm do |x|
      x.report("old:") do
        n.times { User.top_users }
      end
      x.report("new:") do
        n.times { User.leaderboard }
      end
    end
  end
end
