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
  
  def show_table
    @data_list = DataList.find(params[:id])
    @series_to_chart = @data_list.series_data.keys
    frequency = @series_to_chart[0][-1]
    dates = set_dates(frequency, params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
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
    when "M"
      months_back = 15
      offset = 1
    when "Q"
      months_back = 34
      offset = 4
    when "A"
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

end
