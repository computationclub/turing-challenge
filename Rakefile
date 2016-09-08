$LOAD_PATH.unshift("lib")

require "challenge"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

# Add your own rake task below:

task :tuzz do
  Harness.run(Tuzz::V1.new)
end

task :tuzz2 do
  Harness.run(Tuzz::V2.new)
end

# The default task runs the tests then everyone's attempts:

task default: [:spec, :tuzz, :tuzz2]
