require 'stack'

describe Stack do

  it 'is empty when initialised' do
    stack = Stack.new
    expect(stack.size).to eq 0
  end

  it 'can hold one item' do
    stack = Stack.new
    stack.push(2346)
    expect(stack.size).to eq 1
  end

  it 'can remove one item' do
    stack = Stack.new
    stack.push(2346)
    stack.pop
    expect(stack.size).to eq 0
  end

  it 'can return one item' do
    stack = Stack.new
    stack.push(2346)
    expect(stack.pop).to eq 2346
  end

  it 'can peek the last item' do
    stack = Stack.new
    stack.push(2346)
    expect(stack.peek).to eq 2346
  end

end
