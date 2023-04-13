Rails.application.routes.draw do

  get("/", { :controller => "drinks", :action => "show_form" })
  
  get("/cocktail", { :controller => "drinks", :action => "results" })



  get("/solutions", { :controller => "solutions", :action => "display_form" })
  
  get("/solutions/results", { :controller => "solutions", :action => "gpt_response" })

end
