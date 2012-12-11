class DataSourcesController < ApplicationController
  #can eventually move this to a data_source_controller when 
  #that's developed for other source editing facilities
  def source
    source = DataSource.find(params[:id])
    source.reload_source
    redirect_to :controller=> "series", :action => 'show', :id => source.series_id
  end
  
  def clear_and_reload
    source = DataSource.find(params[:id])
    source.clear_and_reload_source
    redirect_to :controller=> "series", :action => 'show', :id => source.series_id
  end
  
  def delete
    source = DataSource.find(params[:id])
    source.delete
    redirect_to :controller=> "series", :action => 'show', :id => source.series_id
  end
  
  def new
    puts "I'm in the NEW actions"
    params.each { |key,value| puts "#{key}: #{value}" }
    @series = Series.find(params[:series_id])
    @data_source = DataSource.new(:series_id => @series.id)
  end

  def edit
    @data_source = DataSource.find(params[:id])
  end

  def update
    params.each { |key,value| puts "#{key}: #{value}" }
    
    @data_source = DataSource.find(params[:id])
     if @data_source.update_attributes(:eval => params[:data_source][:eval])
        @data_source.reload_source
        redirect_to :controller => "series", :action => 'show', :id => @data_source.series_id, :notice => "datasource processed successfully"
      else
        redirect_to :controller => "series", :action => 'show', :id => @data_source.series_id, :notice => "datasource had a problem"
      end
  end
  
  def create
    params.each { |key,value| puts "#{key}: #{value}" }
    @data_source = DataSource.new(params[:data_source])
    if @data_source.create_from_form
      redirect_to :controller => "series", :action => 'show', :id => @data_source.series_id, :notice => "datasource processed successfully"
    else
      @series = Series.find(@data_source.series_id)
      render :action => 'new', :series_id => @data_source.series_id
    end
  end
end
