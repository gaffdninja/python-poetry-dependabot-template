require "dependabot-core"
require "dependabot/dependency"
require "dependabot/file_fetchers"
require "dependabot/file_parsers"
require "dependabot/update_checkers"
require "dependabot/file_updaters"
require "dependabot/metadata_finders"
require "dependabot/pull_request_creator"
require "dependabot/clients/github_with_retries"
require "dependabot/pull_request_updater"
require "dependabot/pip/file_fetcher"
require "dependabot/pip/file_parser"
require "dependabot/pip/update_checker"
require "dependabot/pip/file_updater"
require "dependabot/pip/metadata_finder"

credentials = [{ "type" => "git_source", "host" => "github.com", "token" => ENV["ACCESS_TOKEN"] }]

source = Dependabot::Source.new(
  provider: "github",
  repo: "gaffdninja/python-poetry-dependabot-template",
  directory: "/",
  branch: nil,
  api_endpoint: "https://api.github.com/",
)

fetcher = Dependabot::Pip::FileFetcher.new(source: source, credentials: credentials)
parser = Dependabot::Pip::FileParser.new(source: source, credentials: credentials, dependency_files: fetcher.files)
checker = Dependabot::Pip::UpdateChecker.new(
  dependency: parser.parse[0],
  dependency_files: fetcher.files,
  credentials: credentials
)
updater = Dependabot::Pip::FileUpdater.new(
  dependency_files: fetcher.files,
  update_checker: checker,
  credentials: credentials
)

# Execute the update
updater.updated_dependency_files.each do |updated_file|
  puts updated_file.content
end
