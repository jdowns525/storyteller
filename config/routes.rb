Rails.application.routes.draw do

  get("/", { :controller => "stories", :action => "show_form" })
  
  get("/stories", { :controller => "stories", :action => "results" })



  get("/solutions", { :controller => "solutions", :action => "display_form" })
  
  get("/solutions/results", { :controller => "solutions", :action => "gpt_response" })

end
