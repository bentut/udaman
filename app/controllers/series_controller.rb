class SeriesController < ApplicationController
  def index

    frequency = params.has_key?(:freq) ? params[:freq] : nil
    prefix = params.has_key?(:prefix) ? params[:prefix] : nil
    all = params.has_key?(:all) ? true : false
    
    @all_series = Series.all(:order => :name) if all
    @all_series = Series.where(:frequency => frequency).order(:name).all unless frequency.nil?
    @all_series = Series.all(:conditions => ["name LIKE ?", "#{prefix}%"], :order => :name) unless prefix.nil?
    @all_series ||= [] 
  end

  def show
    @series = Series.find params[:id]
    @as = AremosSeries.get @series.name 
    @chg = @series.annualized_percentage_change
    @ytd_chg = @series.ytd_percentage_change
    @lvl_chg = @series.absolute_change
    @desc = @as.nil? ? "No Aremos Series" : @as.description
    
    respond_to do |format|
      format.csv { render :layout => false }
      format.html # show.html.erb
      format.json { render :json => @series }
    end
  end

  def edit
    @series = Series.find params[:id]
  end
  
  def update
    @series = Series.find(params[:id])

    respond_to do |format|
      if @series.update_attributes(params[:series])
        format.html { redirect_to(@series,
                      :notice => 'Data File successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @series.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @series = Series.find params[:id]
    @series.destroy
    
    redirect_to :action => 'index'
  end
  
  def search
    @search_results = AremosSeries.web_search(params[:search])
  end
  
  def comparison_graph
    @series = Series.find params[:id]
    @comp = @series.aremos_data_side_by_side
  end

  def outlier_graph
    @series = Series.find params[:id]
    @comp = @series.ma_data_side_by_side
    #residuals is actually whole range of values.
    residuals = @comp.map { |date, ma_hash| ma_hash[:udaman] }
    residuals.reject!{|a| a.nil?}
    average = residuals.inject{ |sum, el| sum + el }.to_f / residuals.count
    @std_dev = Math.sqrt((residuals.inject(0){ | sum, x | sum + (x - average) ** 2 }) / (residuals.count - 1))

    
    
    
    #@series.backward_looking_moving_average.standard_deviation
  end
  
  
  def analyze
    @series = Series.find params[:id]
    @chg = @series.annualized_percentage_change
    @as = AremosSeries.get @series.name 
    @desc = @as.nil? ? "No Aremos Series" : @as.description
    @lvl_chg = @series.absolute_change
    @ytd = @series.ytd_percentage_change
  end
  
  def blog_graph
    @series = Series.find params[:id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    chart_to_make = params[:create_post]
    unless chart_to_make.nil?
      @link = chart_to_make == 'line' ? @series.create_blog_post(nil, @start_date, @end_date) : @series.create_blog_post(chart_to_make, @start_date, @end_date)
    end
    @chart_made = chart_to_make
  end
  
  def validate
    @series = Series.find(params[:id])
    @prognoz_data_results = @series.prognoz_data_results
  end
  
  def replace_block
    render :partial => "replace_block"
  end
  
  def toggle_units
    @series = Series.find(params[:id])
    @series.units = params[:units]
    #@series.save
    @series.aremos_comparison(true)
    @as = AremosSeries.get @series.name
    render :partial => "toggle_units.html"
  end
  
  def render_data_points
    @series = Series.find params[:id]
    
    render :partial => 'data_points', :locals => {:series => @series, :as => @as}
  end
  
  def toggle_multiplier
    @series = Series.find(params[:id])
    @series.toggle_mult
    #@series.save
    @output_file = PrognozDataFile.find @series.prognoz_data_file_id
    @output_file.update_series_validated_for @series
    render :partial => "validate_row"
  end

  def update_notes
    @series = Series.find(params[:id])
    @series.update_attributes({:investigation_notes => params[:note]})
    render :partial => "investigation_sort.html"
  end


end
