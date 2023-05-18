require "swagger_helper"

RSpec.describe "people", type: :request do
  path "/people/{id}" do
    get("show person") do
      parameter name: "id", in: :path, type: :string, description: "Person ID"

      response(200, "successful") do
        let(:id) { create(:person).id }

        schema "$ref" => "#/components/schemas/person"

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(404, "not found") do
        let(:id) { 0 }

        schema "$ref" => "#/components/schemas/error"

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
