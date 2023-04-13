class SolutionsController < ApplicationController
  def display_form
    render({ :template => "solutions/display_form.html.erb" })
  end

  def gpt_response
    @inspiration_name = params.fetch(:person)

    require "openai"

    openai_client = OpenAI::Client.new(
      access_token: ENV.fetch("OPENAI_API_KEY"),
    )

    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5 turbo",
        messages: [
          { role: "system", content: "You are a clever mixologist. Make up a funny cocktail name based on the provided name, as well as a recipe for the cocktail." },
          { role: "user", content: "My friend's name is #{@inspiration_name}. Can you think of a clever cocktail name based on their name?" },
        ],
        temperature: 1.0,
      },
    )

    @result = response.fetch("choices").at(0).fetch("message").fetch("content")

    render({ :template => "solutions/gpt_response.html.erb" })
  end
end
