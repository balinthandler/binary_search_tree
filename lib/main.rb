# frozen_string_literal: true

# Node class for Tree nodes
class Node
  include Comparable
  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def data
    @data
  end

  def get_left
    @left
  end

  def get_right
    @right
  end

  def set_left(value)
    @left = value
  end

  def set_right(value)
    @right = value
  end
end

# Tree class for Binary Search Tree
class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree
    return puts "There is nothing to sort - Empty Array" if @array.empty?

    sorted = merge_sort(@array.uniq)
    @root = node_builder(sorted, 0, sorted.length - 1)
  end

  def node_builder(array, first, last)
    return nil if first > last

    mid = (first + last) / 2
    node = Node.new(array[mid])
    node.set_left(node_builder(array, first, mid - 1))
    node.set_right(node_builder(array, mid + 1, last))
    @root = node
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
    return result += left if right.empty?
    return result += right if left.empty?
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    return puts "Nothing to print" if node.nil?

    pretty_print(node.get_right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.get_right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.get_left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.get_left
  end
end

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

bst = Tree.new(test_array)
bst.build_tree
bst.pretty_print
