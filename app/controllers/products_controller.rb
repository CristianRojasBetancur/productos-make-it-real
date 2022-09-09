class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def create
    selected_categories = params[:categories]
    @product = Product.new(product_params)
    puts "---------------#{selected_categories}---------------"

    unless selected_categories.nil?
      selected_categories.each do |category_id|
        Category.all.each do |category|
          if category.id == category_id.to_i
            @product.categories << category
          end
        end
      end
    end


    if @product.save
      redirect_to products_path, notice: "Producto creado con éxito"
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
    @product = Product.find(params[:id])
    @product.categories.each do |category|
      @checked_categories = category.id
    end
  end

  def update
    selected_categories = params[:categories]
    @product = Product.find(params[:id])
    @product.categories.destroy_all

    unless selected_categories.nil?
      selected_categories.each do |category_id|
        Category.all.each do |category|
          if category.id == category_id.to_i
            @product.categories << category
          end
        end
      end
    end

    @product.update(product_params)

    redirect_to products_path
  end

  def destroy
    product = Product.find(params[:id])
    product.categories.destroy_all
    product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :categories)
  end
end
