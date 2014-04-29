class DataListsController < ApplicationController
  # GET /data_lists
  # GET /data_lists.xml
  def index
    @data_lists = DataList.order(:name).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_lists }
    end
  end

  # GET /data_lists/1
  # GET /data_lists/1.xml
  def show
    @data_list = DataList.find(params[:id])

    respond_to do |format|
      format.csv { render :layout => false }
      format.html # show.html.erb
      format.xml  { render :xml => @data_list }
    end
  end
  
  def super_table
    @freq = params[:freq]
    @data_list = DataList.find(params[:id])
    # @series_to_chart = @data_list.series_names
    # frequency = @series_to_chart[0][-1]
    # dates = set_dates(frequency, params)
    # @start_date = dates[:start_date]
    # @end_date = dates[:end_date]
    render "super_table"
  end
  
  def show_table
    @data_list = DataList.find(params[:id])
    @series_to_chart = @data_list.series_names
    frequency = @series_to_chart[0][-1]
    dates = set_dates(frequency, params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end


#NOTE DATA LIST NEEDS TO BE ALL CAPS... SOMETHING TO FIX. Not the case for regular super table
  def show_tsd_super_table
    @data_list = DataList.find(params[:id])
    @all_tsd_files = JSON.parse(open("http://readtsd.herokuapp.com/listnames/json").read)["file_list"]
    @tsd_file = params[:tsd_file].nil? ? @all_tsd_files[0] : params[:tsd_file]
    render "tsd_super_tableview"
  end
  
  def show_tsd_table
    @data_list = DataList.find(params[:id])
    @all_tsd_files = JSON.parse(open("http://readtsd.herokuapp.com/listnames/json").read)["file_list"]
    @tsd_file = params[:tsd_file].nil? ? @all_tsd_files[0] : params[:tsd_file]
    @series_to_chart = @data_list.series_names
    frequency = @series_to_chart[0][-1]
    dates = set_dates(frequency, params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tsd_tableview"
  end
  
  def analyze_view
    @data_list = DataList.find(params[:id])
    @all_tsd_files = JSON.parse(open("http://readtsd.herokuapp.com/listnames/json").read)["file_list"]
    @tsd_file = params[:tsd_file].nil? ? @all_tsd_files[0] : params[:tsd_file]
    @series_name = params[:list_index].nil? ? params[:series_name] : @data_list.series_names[params[:list_index].to_i]
    #@series_name = @data_list.series_names[@series_index]

    @data = json_from_heroku_tsd(@series_name,@tsd_file)
		@series = @data.nil? ? nil : Series.new_transformation(@data["name"]+"."+@data["frequency"],  @data["data"], Series.frequency_from_code(@data["frequency"]))
		@chg = @series.annualized_percentage_change
    #@as = AremosSeries.get @series.name 
    @desc = "None yet" #@as.nil? ? "No Aremos Series" : @as.description
    @lvl_chg = @series.absolute_change
    @ytd = @series.ytd_percentage_change
  end
  
  def compare_forecasts
    @data_list = DataList.find(params[:id])
    @all_tsd_files = JSON.parse(open("http://readtsd.herokuapp.com/listnames/json").read)["file_list"]
  end
  
  def compare_view
    @data_list = DataList.find(params[:id])
    @tsd_file1 = "heco14.TSD"
    @tsd_file2 = "13Q4.TSD"
    @series_name = params[:list_index].nil? ? params[:series_name] : @data_list.series_names[params[:list_index].to_i]

    @data1 = json_from_heroku_tsd(@series_name,@tsd_file1)
		@series1 = @data1.nil? ? nil : Series.new_transformation(@data1["name"]+"."+@data1["frequency"],  @data1["data"], Series.frequency_from_code(@data1["frequency"])).trim("2006-01-01","2017-10-01")
		@chg1 = @series1.annualized_percentage_change
    
    @data2 = json_from_heroku_tsd(@series_name,@tsd_file2)
		@series2 = @data2.nil? ? nil : Series.new_transformation(@data2["name"]+"."+@data2["frequency"],  @data2["data"], Series.frequency_from_code(@data2["frequency"])).trim("2006-01-01","2017-10-01")
		@chg2 = @series2.annualized_percentage_change

    @history_series = @series_name.ts.trim("2006-01-01","2017-10-01")
    @history_chg = @history_series.annualized_percentage_change
  end
  
  # GET /data_lists/new
  # GET /data_lists/new.xml
  def new
    @data_list = DataList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_list }
    end
  end

  # GET /data_lists/1/edit
  def edit
    @data_list = DataList.find(params[:id])
  end

  # POST /data_lists
  # POST /data_lists.xml
  def create
    @data_list = DataList.new(params[:data_list])

    respond_to do |format|
      if @data_list.save
        format.html { redirect_to(@data_list, :notice => 'Data list was successfully created.') }
        format.xml  { render :xml => @data_list, :status => :created, :location => @data_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_lists/1
  # PUT /data_lists/1.xml
  def update
    @data_list = DataList.find(params[:id])

    respond_to do |format|
      if @data_list.update_attributes(params[:data_list])
        format.html { redirect_to(@data_list, :notice => 'Data list was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_lists/1
  # DELETE /data_lists/1.xml
  def destroy
    @data_list = DataList.find(params[:id])
    @data_list.destroy

    respond_to do |format|
      format.html { redirect_to(data_lists_url) }
      format.xml  { head :ok }
    end
  end
  
  
private
  def set_dates(frequency, params)
    case frequency
    when "M", "m"
      months_back = 15
      offset = 1
    when "Q", "q"
      months_back = 34
      offset = 4
    when "A", "a"
      months_back = 120
      offset = 4
    end
    
    if params[:num_years].nil?
      start_date = (Time.now.to_date << (months_back)).to_s
      end_date = nil
    else
      start_date = (Time.now.to_date << (12 * params[:num_years].to_i + offset)).to_s
      end_date = nil
    end
    return {:start_date => start_date, :end_date => end_date}
  end
  
  def json_from_heroku_tsd(series_name, tsd_file)
    url = URI.parse("http://readtsd.herokuapp.com/open/#{tsd_file}/search/#{series_name[0..-3]}/json")
    res = Net::HTTP.new(url.host, url.port).request_get(url.path)
    data = res.code == "500" ? nil : JSON.parse(res.body)  
  end

end
