Resque.logger = Logger.new(Rails.root.join("log", "#{Rails.env}_resque.log"))
Resque.logger.level = Logger::INFO
Resque.redis = "localhost:6379"
