class Entry
  attr_reader :issue, :date, :hours, :comment, :activity

  def initialize(args)
    @issue = args.fetch(:issue)
    @date = args.fetch(:date)
    @hours = args.fetch(:hours)
    @comment = args.fetch(:comment)
    @activity = args.fetch(:activity)
  end

  def to_s        
    "Logged: Date: #{date}; Hours: #{hours}; Activity: #{activity}; Comment: #{comment}; Issue: #{issue}"
  end
end
