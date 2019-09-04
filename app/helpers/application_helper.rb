module ApplicationHelper
  include Pagy::Frontend

  def rating_range(rating)
    rating *= 10 if rating % 1 != 0
    case rating
    when (75..100)
      "has-background-success"
    when (50..74)
      "has-background-warning"
    when (0..49)
      "has-background-danger"
    end
  end

  def float_rating_range(rating)
    case rating
    when (7.5..10.0)
      "has-background-success"
    when (5.0..7.4)
      "has-background-warning"
    when (0.0..4.9)
      "has-background-danger"
    end
  end
end
