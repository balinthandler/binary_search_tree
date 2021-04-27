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
    @array.uniq!
    merge_sort(@array)
    # @root
  end
  def merge_sort(array)
    return array if array.length < 2
    left = array[0, array.length / 2]
    right = array[array.length / 2, array.length - 1]
    merge(merge_sort(left), merge_sort(right))
  end
  
  def merge(left, right)
    result = []
    while !left.empty? && !right.empty?
      if left[0] <= right[0]
        result << left[0]
        left.slice!(0)
      else
        result << right[0]
        right.slice!(0)
      end
    end
    result += left if right.empty?
    result += right if left.empty?
    result
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

test_array = [5,0,2,7,4,10,9,3,1,8,6,4,2,6]
bst = Tree.new(test_array)
p bst.build_tree