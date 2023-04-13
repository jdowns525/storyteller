class SolutionsController < ApplicationController
  def display_form
    render({ :template => "solutions/display_form.html.erb" })
  end

  def gpt_response
    @inspiration_prompt = params.fetch(:prompt)

    require "openai"

    openai_client = OpenAI::Client.new(
      access_token: ENV.fetch("OPENAI_API_KEY"),
    )

    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5 turbo",
        messages: [
          { role: "system", content: "You are Dr. Seuss . Make up a witty short story for children based on the prompt it provides. Please provide rich fantasy detail." },
          { role: "user", content: "My child's choice is #{@inspiration_prompt}. Can you think of a clever shorty story based on their prompt?" },
        ],
        temperature: 1.0,
      },
    )

    @result = response.fetch("choices").at(0).fetch("message").fetch("content")

    render({ :template => "solutions/gpt_response.html.erb" })
  end
end
