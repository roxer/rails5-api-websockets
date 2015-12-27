class Swagger::Docs::Config
  def self.base_api_controller
    ActionController::Base
  end
end

Swagger::Docs::Config.register_apis({
    "1.0" => {
        :controller_base_path => "",
        # the extension used for the API
        :api_extension_type => :json,
        # the output location where your .json files are written to
        :api_file_path => "public/docs/",
        # the URL base path to your API
        # :base_path => "/",
        :base_path => "//",
        # if you want to delete all .json files at each generation
        :clean_directory => true,
        # add custom attributes to api-docs
        :attributes => {
            :info => {
                "title" => "Diagraroo App",
                "description" => "This is an API for an online real-time diagram editor",
                "termsOfServiceUrl" => "https://github.com/roxer/rails-5-api-websockets",
                "contact" => "roxermc@gmail.com",
                "license" => "MIT",
                "licenseUrl" => "https://github.com/roxer/rails5-api-websockets/blob/master/LICENSE"
            }
        }
    }
})
