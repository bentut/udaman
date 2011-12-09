class DataLoadMailer < ActionMailer::Base
  default :from => "btrevino@hawaii.edu"
  
  def download_notification(update_info, update_summary)
    @update_info = update_info
    @update_summary = update_summary
    mail(:to => "bentut@gmail.com", :subject => "A spreadsheet was updated: #{update_info}")
  end
end
