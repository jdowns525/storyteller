class StoriesController < ApplicationController
  def show_form
    render({ :template => "story_templates/the_form.html.erb" })
  end

  def results
    @the_prompt = params.fetch("prompt")

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

    @response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [
            { role: "system", content: "You are Dr. Seuss . Make up a witty short story for children based on the prompt it provides. Please provide rich fantasy detail." },
            { role: "user", content: @the_prompt}
          ], # Required.
          temperature: 0.7,
      })

    @result = @response.fetch("choices").at(0).fetch("message").fetch("content")
    
    render({ :template => "story_templates/results.html.erb" })
  end
end
