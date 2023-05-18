class PeopleController < ApplicationController
  def show
    person = Person.find_by(id: params[:id])

    if person
      render json: person
    else
      render json: {error: "not found"}, status: 404
    end
  end
end
