require 'loader'
require 'tempfile'

describe Loader do

  it 'loads a binary file' do
    loader = Loader.new
    test = create_testfile("aa")
    expect(loader.readfile(test)).to eq [24929]
  end

  private

  def create_testfile content
    test = Tempfile.new('test')
    test.write(content)
    test.rewind
    test
  end

end
