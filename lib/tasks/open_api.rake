namespace :open_api do
  desc "Validate OpenAPI documentation"
  task validate: :environment do
    schema = File.read(Rails.root.join("docs/open-api-schema.json"))
    doc = File.read(Rails.root.join("swagger/v1/swagger.json"))

    JSON::Validator.validate!(schema, doc)

    puts "swagger/v1/swagger.json is valid"
  end
end
