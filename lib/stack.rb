class Stack

  attr_reader :items

  def initialize
    @items = []
  end

  def size
    items.count
  end

  def push item
    items.push item
  end

  def pop
    items.pop
  end

  def peek
    items.last
  end

end
