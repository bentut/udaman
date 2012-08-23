task :write_empl_dash => :environment do
  
  desc "writes employment level charts to website"
  
  view = ActionView::Base.new(ActionController::Base.view_paths, {})
  
  post_body = '' + view.render(:file=> "/dashboards/_jobs_chart.html.erb")
  
  require 'mechanize'
  agent = Mechanize.new do |a|
    a.keep_alive = false
  end
  
  login_page = agent.get('http://www.uhero.hawaii.edu/admin/login')
  
  dashboard = login_page.form_with(:action => '/admin/login') do |f|
    f.send("data[User][login]=", SITE['pub_user'])
    f.send("data[User][pass]=", SITE['pub_pass'])
  end.click_button
  
  new_product_page = agent.get('http://www.uhero.hawaii.edu/admin/pages/edit/124')

  conf_page = new_product_page.form_with(:action => "/admin/pages/edit/124") do |f|
    f.send("data[Page][title]=", "Employment Levels in Hawaii")
    f.send("data[Page][content]=", post_body)
    f.send("action=", '/admin/pages/edit/124/autoPublish:1')    
  end.click_button
end


task :write_ur_dash => :environment do
  
  desc "writes unemployment rate charts to website"
  
  view = ActionView::Base.new(ActionController::Base.view_paths, {})
  
  post_body = '' + view.render(:file=> "/dashboards/_unemployment_chart.html.erb")
  #post_body = "Hello World"
  
  require 'mechanize'
  agent = Mechanize.new do |a|
    a.keep_alive = false
  end
  
  login_page = agent.get('http://www.uhero.hawaii.edu/admin/login')
  
  dashboard = login_page.form_with(:action => '/admin/login') do |f|
  	f.send("data[User][login]=", SITE['pub_user'])
  	f.send("data[User][pass]=", SITE['pub_pass'])
  end.click_button
  
  new_product_page = agent.get('http://www.uhero.hawaii.edu/admin/pages/edit/123')
  
  
  conf_page = new_product_page.form_with(:action => '/admin/pages/edit/123') do |f|    
  	f.send("data[Page][title]=", "Unemployment Rates in Hawaii (Seasonally Adjusted)")
  	f.send("data[Page][content]=", post_body)
  	f.send("action=", '/admin/pages/edit/123/autoPublish:1')    
  end.click_button
end
  
  
task :write_sector_dash => :environment do
  
  desc "writes interactive job sector chart to website"
  
  view = ActionView::Base.new(ActionController::Base.view_paths, {})
  
  post_body = '' + view.render(:file=> "/dashboards/_sector_chart_final.html.erb")
  
  require 'mechanize'
  agent = Mechanize.new do |a|
    a.keep_alive = false
  end
  
  login_page = agent.get('http://www.uhero.hawaii.edu/admin/login')
  
  dashboard = login_page.form_with(:action => '/admin/login') do |f|
    f.send("data[User][login]=", SITE['pub_user'])
    f.send("data[User][pass]=", SITE['pub_pass'])
  end.click_button
  
  new_product_page = agent.get('http://www.uhero.hawaii.edu/admin/pages/edit/128')

  conf_page = new_product_page.form_with(:action => "/admin/pages/edit/128") do |f|
    f.send("data[Page][title]=", "Jobs Data By Sector")
    f.send("data[Page][content]=", post_body)
    f.send("action=", '/admin/pages/edit/128/autoPublish:1')    
  end.click_button
  
  puts conf_page
  
end
