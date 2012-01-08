class PackagerMailer < ActionMailer::Base
  default :from => "udaman@hawaii.edu"
  
  def rake_notification(rake_task, download_string, error_string, summary_string)
    @download_string = download_string
    @error_string = error_string
    @summary_string = summary_string
    mail(:to => ["bentut@gmail.com","btrevino@hawaii.edu"], :subject => "UDAMAN New Download or Error (#{rake_task})")
  end
end
