class SalesService
  def initialize(params)
    @params = params
  end

  #returns filtered sales and all sales
  def sales
    if from_date && to_date
      Sale.where(sales_date: from_date.beginning_of_day..to_date.end_of_day).order(sales_date: :asc)
    else
      Sale.all.order(sales_date: :asc)
    end
  end

  #returns json data
  def as_json
    sales.as_json(
      methods: %i[salesperson_commission discounted_price],
      include: {
        product: { only: %i[id name] },
        salesperson: { only: %i[first_name last_name] },
        customer: { only: %i[first_name last_name] }
      }
    )
  end

  private

  attr_reader :params

  def from_date
    Date.parse(params[:from_date]) if params[:from_date].present?
  end

  def to_date
    Date.parse(params[:to_date]) if params[:to_date].present?
  end
end
