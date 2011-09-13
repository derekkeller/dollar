class OrdersController < ApplicationController

  def order_filter
    begin
      if params[:date][:start_month].present? &&
         params[:date][:start_year].present? &&
         params[:date][:end_month].present? &&
         params[:date][:end_year].present?

        start_period = Date.civil(params[:date][:start_year].to_i, params[:date][:start_month].to_i)
        end_period = Date.civil(params[:date][:end_year].to_i, params[:date][:end_month].to_i)
      end
    rescue
      start_period = Date.today - 1000
      end_period = Date.today
    end

    @filtered_orders = Order.where(["date_ordered between ? AND ?", start_period, end_period]).all

    render :update do |page|
      page.replace_html :filtered_results_container, render(:partial => 'filtered_partial')
    end

  end

  def index
    @filtered_orders = Order.all    
  end

  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.save
      redirect_to :root, :flash => { :success => "Order created." }
    else
      render :new
    end    
  end

  def edit
    @order = Order.find(params[:id])    
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to :root, :flash => { :success => "Order updated."}
    else
      render :edit
    end    
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to :root, :flash => { :success => "Order deleted."}
  end

end