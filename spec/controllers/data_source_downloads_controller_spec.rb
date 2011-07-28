require 'spec_helper'

describe DataSourceDownloadsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'download'" do
    it "should be successful" do
      get 'download'
      response.should be_success
    end
  end

  describe "GET 'test_url'" do
    it "should be successful" do
      get 'test_url'
      response.should be_success
    end
  end

  describe "GET 'test_save_path'" do
    it "should be successful" do
      get 'test_save_path'
      response.should be_success
    end
  end

  describe "GET 'test_post_params'" do
    it "should be successful" do
      get 'test_post_params'
      response.should be_success
    end
  end

end
