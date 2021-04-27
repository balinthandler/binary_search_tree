class Node 
  include Comparable
  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end
  
end

class Tree 
  def initialize(array)
    @array = array
    @root = nil
  end
  def build_tree
    @root
  end
  def insert
  end
  def delete
  end
  def find
  end
  def level_order
  end
  def inorder
  end
  def preorder
  end
  def postorder
  end
  def height
  end
  def depth
  end
  def balanced?
  end
  def rebalance
  end
  
end