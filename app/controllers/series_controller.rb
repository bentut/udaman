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
  
  # def website_post
  #   @series = Series.find params[:id]
  #   @start_date = params[:start_date]
  #   @end_date = params[:end_date]
  # 
  #   start_date = @start_date.nil? ? (Time.now.to_date << (15)).to_s : @start_date.to_s
  #   end_date = @end_date.nil? ? Time.now.to_date.to_s : @end_date.to_s
  #   plot_data = @series.get_values_after(start_date,end_date)
  #   a_series = AremosSeries.get(@series.name)
  #   chart_id = @series.id.to_s+"_"+Date.today.to_s
  #   
  #   if params[:bar_type] == "yoy"
  #     bar_data = @series.annualized_percentage_change.data
  #     bar_id_label = "yoy"
  #     bar_color = "#AAAAAA"
  #     bar_label = "YOY % Change"
  #     render :partial => 'blog_chart_line_bar', :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id, :bar_id_label=>bar_id_label, :bar_label => bar_label, :bar_color => bar_color, :bar_data => bar_data }
  #   elsif params[:bar_type] == "ytd"
  #     bar_data = @series.ytd_percentage_change.data 
  #     bar_id_label = "ytd"
  #     bar_color = "#AAAAAA"
  #     bar_label = "YTD % Change"
  #     render :partial => 'blog_chart_line_bar', :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id, :bar_id_label=>bar_id_label, :bar_label => bar_label, :bar_color => bar_color, :bar_data => bar_data }
  #   else
  #     render :partial => 'blog_chart_line', :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id}
  #   end    
  #   
  #   
  #   #render :partial => "data_points", :locals => {:series => @series, :as => @as, :chg => @chg, :ytd_chg => @ytd_chg}
  # end
  
  def comparison_graph
    @series = Series.find params[:id]
    @comp = @series.aremos_data_side_by_side
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

  # # GET /series
  # # GET /series.xml
  # def index
  #   @series = Series.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @series }
  #   end
  # end
  # 
  # # GET /series/1
  # # GET /series/1.xml
  # def show
  #   @series = Series.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @series }
  #   end
  # end
  # 
  # # GET /series/new
  # # GET /series/new.xml
  # def new
  #   @series = Series.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @series }
  #   end
  # end
  # 
  # # GET /series/1/edit
  # def edit
  #   @series = Series.find(params[:id])
  # end
  # 
  # # POST /series
  # # POST /series.xml
  # def create
  #   @series = Series.new(params[:series])
  # 
  #   respond_to do |format|
  #     if @series.save
  #       format.html { redirect_to(@series, :notice => 'Series was successfully created.') }
  #       format.xml  { render :xml => @series, :status => :created, :location => @series }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /series/1
  # # PUT /series/1.xml
  # def update
  #   @series = Series.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @series.update_attributes(params[:series])
  #       format.html { redirect_to(@series, :notice => 'Series was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /series/1
  # # DELETE /series/1.xml
  # def destroy
  #   @series = Series.find(params[:id])
  #   @series.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(series_index_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
