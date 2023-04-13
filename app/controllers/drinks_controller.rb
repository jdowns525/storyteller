class DrinksController < ApplicationController
  def show_form
    render({ :template => "drink_templates/the_form.html.erb" })
  end

  def results
    @the_name = params.fetch("person")


    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

    @response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [
            { role: "system", content: "You are a clever bartender. Make up a witty name for a cocktail based on the name that the user provides. Please provide the recipe also." },
            { role: "user", content: @the_name}
          ], # Required.
          temperature: 0.7,
      })

    @result = @response.fetch("choices").at(0).fetch("message").fetch("content")
    
    render({ :template => "drink_templates/results.html.erb" })
  end
end
