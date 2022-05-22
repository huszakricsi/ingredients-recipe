RSpec.shared_context 'stdout' do
  let(:stdout) { $stdout }
  around :each do |example|
    original_stdout = $stdout.dup
    $stdout = StringIO.new
    begin
      example.run
    ensure
      $stdout = original_stdout.dup
    end
  end
end
