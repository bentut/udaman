
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
    f.send("data[Page][title]=", "Job Sector Performance Visualization")
    f.send("data[Page][content]=", post_body)
    f.send("action=", '/admin/pages/edit/128/autoPublish:1')    
  end.click_button
  
  puts conf_page
  
end
