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
end
