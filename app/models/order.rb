class Order < ApplicationRecord
  belongs_to :order_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
