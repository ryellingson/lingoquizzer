class GameDataGenerator < ApplicationService
  require "google/cloud/translate"

  def initialize(game_data, target_language)
   # initializes a client
 　 @translate = Google::Cloud::Translate.new version: :v2, project_id: ENV["CLOUD_PROJECT_ID"]
    @target_language = target_language
    @game_data = JSON.parse(File.open(game_data))
    # loads the japanese game file
    # sets the target langauge
  end

  def call
    # extract the English words from the icons name
    # use an api to get translations of list into target language
    # build the formatted hash with the question for target language
    # create a JSON with a list of question icons and an answers
  end
end
