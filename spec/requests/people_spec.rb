require "swagger_helper"

RSpec.describe "people", type: :request do
  path "/people" do
    post("create person") do
      consumes "application/json"
      produces "application/json"

      parameter name: "person", in: :body, schema:
        {
          type: "object",
          properties: {
            first_name: {type: "string"},
            last_name: {type: "string"}
          },
          required: %w[first_name last_name]
        }

      response(201, "successful") do
        let(:person) { build(:person).attributes.slice("first_name", "last_name") }

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

      response(400, "missing body") do
        let(:person) { {} }

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

      response(422, "invalid") do
        let(:person) { {first_name: "David"} }

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

  path "/people/{id}" do
    get("show person") do
      produces "application/json"

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
