# dependabot-script.rb

require "dependabot-core"
require "dependabot/dependency"
require "dependabot/dependency_group"
require "dependabot/file_fetchers"
require "dependabot/file_parsers"
require "dependabot/update_checkers"
require "dependabot/file_updaters"
require "dependabot/metadata_finders"
require "dependabot/pull_request_creator"
require "dependabot/clients/github_with_retries"
require "dependabot/pull_request_updater"

credentials = [{ "type" => "git_source", "host" => "github.com", "token" => ENV["ACCESS_TOKEN"] }]

source = Dependabot::Source.new(
  provider: "github",
  repo: "gaffdninja/python-poetry-dependabot-template",
  directory: "/",
  branch: nil,
  api_endpoint: "https://api.github.com/",
)

updater = Dependabot::FileUpdaters::Python::Pip.new(
  credentials: credentials,
  source: source,
)

updater.update_all
