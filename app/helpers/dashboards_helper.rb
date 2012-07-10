module DashboardsHelper
  require 'csv'

  def investigate_csv_helper
    CSV.generate do |csv|        
      @diff_data.each do |dd|
        csv << [dd[:name]] + [dd[:id]] + dd[:display_array]
      end
    end
  end
  
end
