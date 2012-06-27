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
    @desc = @as.nil? ? "No Aremos Series" : @as.description
    @pdf = PrognozDataFile.find @series.prognoz_data_file_id unless @series.prognoz_data_file_id.nil?
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
  
  def blog_graph
    @series = Series.find params[:id]
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
    @series.aremos_comparison
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
    @series.save
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
