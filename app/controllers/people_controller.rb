class PeopleController < ApplicationController
  rescue_from ActionController::ParameterMissing do |e|
    render json: {error: e.message}, status: 400
  end

  def create
    person = Person.new(person_params)

    if person.save
      render json: person, status: 201
    else
      render json: {error: person.errors.full_messages.join("; ")}, status: 422
    end
  end

  def show
    person = Person.find_by(id: params[:id])

    if person
      render json: person
    else
      render json: {error: "not found"}, status: 404
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name)
  end
end
