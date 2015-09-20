class OutputHelper
  def self.capture_stdout(&block)
    original = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original
    end
    fake.string
  end
end
