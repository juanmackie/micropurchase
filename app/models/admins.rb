class Admins
  def verify?(github_id)
    return false if github_id.nil?
    github_ids.include?(github_id.to_s)
  end

  def github_ids
    self.class.github_ids.map(&:to_s)
  end

  def self.github_ids
    @github_ids ||= YAML.load(File.read(File.expand_path("../../../config/admins.yml", __FILE__)))['github_ids']
  end

  def self.verify?(uid)
    new.verify?(uid)
  end

  def self.verify_or_fail!(uid)
    fail UnauthorizedError::MustBeAdmin unless verify?(uid)
    true
  end
end
