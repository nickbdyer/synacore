require 'console'

describe Console do

  it 'can print a string' do
    output = StringIO.new
    console = Console.new(StringIO.new, output)
    console.print "Hello, World!"
    expect(output.string).to eq "Hello, World!"
  end

end
