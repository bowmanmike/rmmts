class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  validates :name, presence: true
  validates :frequency_integer, numericality: {only_integer: true}

  after_save :test_job_job

  def test_job_job
    # @chore = Chore.order(updated_at: :desc).first
    TestJobJob.perform_later
  end

  def check_status
    return if !self.recurring?
    if self.complete?
      self.complete = false
      update_due_date
    else
      update_due_date
    end
  end

  def update_due_date
    options = { self.frequency_unit.to_sym => self.frequency_integer }
    self.due_date = self.due_date.advance(options)
    self.save
  end

  def frequency_alias
      
    case self.frequency_integer
    when 1
      "daily"
    when 7
      "weekly"
    when 14
      "bi-weekly"
    else
      "every #{self.frequency} days(s)"
    end

  end
end
