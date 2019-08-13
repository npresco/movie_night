class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user

  validate do
    if choices.values.any? { |v| ["1","0","-1"].exclude?(v) }
      errors.add(:choices, "Outside vote range")
    end
  end
end
