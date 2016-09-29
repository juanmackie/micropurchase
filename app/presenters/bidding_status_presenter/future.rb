class BiddingStatusPresenter::Future < BiddingStatusPresenter::Base
  def start_label
    "Bid start time"
  end

  def deadline_label
    "Bid deadline"
  end

  def relative_time
    "Starting #{HumanTime.new(time: auction.started_at).relative_time}"
  end

  def label_class
    'future'
  end

  def label
    'Coming soon'
  end

  def tag_data_value_status
    HumanTime.new(time: auction.started_at).relative_time
  end

  def tag_data_label_2
    "Starting bid"
  end

  def tag_data_value_2
    Currency.new(auction.start_price).to_s
  end
end
