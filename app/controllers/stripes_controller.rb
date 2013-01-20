class StripesController < ApplicationController
  # GET /stripes
  # GET /stripes.json
  def index
    @stripes = Stripe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stripes }
    end
  end

  # GET /stripes/1
  # GET /stripes/1.json
  def show
    @stripe = Stripe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stripe }
    end
  end

  # GET /stripes/new
  # GET /stripes/new.json
  def new
    @stripe = Stripe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stripe }
    end
  end

  # GET /stripes/1/edit
  def edit
    @stripe = Stripe.find(params[:id])
  end

  # POST /stripes
  # POST /stripes.json
  def create
    @stripe = Stripe.new(params[:stripe])

    respond_to do |format|
      if @stripe.save
        format.html { redirect_to @stripe, notice: 'Stripe was successfully created.' }
        format.json { render json: @stripe, status: :created, location: @stripe }
      else
        format.html { render action: "new" }
        format.json { render json: @stripe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stripes/1
  # PUT /stripes/1.json
  def update
    @stripe = Stripe.find(params[:id])

    respond_to do |format|
      if @stripe.update_attributes(params[:stripe])
        format.html { redirect_to @stripe, notice: 'Stripe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stripe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stripes/1
  # DELETE /stripes/1.json
  def destroy
    @stripe = Stripe.find(params[:id])
    @stripe.destroy

    respond_to do |format|
      format.html { redirect_to stripes_url }
      format.json { head :no_content }
    end
  end
end
