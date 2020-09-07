class Event < ApplicationRecord
	VALID_DATE_REGEX = /\d{4}\-\d{2}\-\d{2}/
	validates :title, presence: true
	validates :date, presence: true,format: { with: VALID_DATE_REGEX }
	belongs_to :user
end
