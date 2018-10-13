class Processor

  def run instructions
    instructions.each do |instruction|
      exit if instruction == 0
    end
  end

end
