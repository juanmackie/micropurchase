class Admin::UserAuctionViewModel
  attr_reader :auction, :user

  DATE_FORMAT = '%m/%d/%Y'.freeze
  NA_RESPONSE_STRING = '-'

  def initialize(auction, user)
    @auction = auction
    @user = user
  end

  def title
    auction.title
  end

  def id
    auction.id
  end

  def start_date
    DcTimePresenter.convert_and_format(auction.started_at, DATE_FORMAT, timezone_label: false)
  end

  def end_date
    DcTimePresenter.convert_and_format(auction.ended_at, DATE_FORMAT, timezone_label: false)
  end

  def user_bid_count
    user_bids.count
  end

  def user_won_label
    if auction_over?
      if user_won?
        'Yes'
      else
        'No'
      end
    else
      NA_RESPONSE_STRING
    end
  end

  def accepted_label
    if user_won?
      if auction_accepted?
        'Yes'
      else
        'No'
      end
    else
      NA_RESPONSE_STRING
    end
  end

  private

  def user_won?
    auction_over? && WinningBid.new(auction).find.bidder == user
  end

  def auction_over?
    AuctionStatus.new(auction).over?
  end

  def auction_accepted?
    auction.accepted?
  end

  def auction_rules
    RulesFactory.new(auction).create
  end

  def user_bids
    auction.bids.where(bidder: user).sort_by(&:amount)
  end
end
