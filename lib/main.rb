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

  def set_data(value)
    @data = value
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
  def initialize
    @root = nil
  end

  def build_tree(array)
    return puts "There is nothing to sort - Empty Array" if array.empty?

    sorted = merge_sort(array.uniq)
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
    return result + left if right.empty?
    return result + right if left.empty?
  end

  def insert(root, key)
    return Node.new(key) if root.nil? 

    if root.data == key
      root
    elsif root.data < key
      root.set_right(insert(root.get_right, key))
    else
      root.set_left(insert(root.get_left, key))
    end
    root
  end

  def delete(root, key)
    return root if root.nil?

    if root.data < key
      root.set_right(delete(root.get_right, key))
    elsif root.data > key
      root.set_left(delete(root.get_left, key))
    else
      if root.get_left.nil?
        tmp = root.get_right
        root = nil
        return tmp
      elsif root.get_right.nil?
        tmp = root.get_left
        root = nil
        return tmp
      end

      successor_parent = root
      successor = root.get_right
      while successor.get_left
        successor_parent = successor
        successor = successor.get_left
      end

      if successor_parent != root
        successor_parent.set_left(successor.get_right)
      else
        successor_parent.set_right(successor.get_right)
      end
      root.set_data(successor.data)
    end
    root
  end

  def min_value(root)
    until root.get_left.nil?
      root = root.get_left
    end
    root
  end

  def find(root, key)
    return root if root.nil? || root.data == key

    if root.data < key
      find(root.get_right, key)
    else
      find(root.get_left, key)
    end
  end

  def root
    @root
  end

  def level_order_iterative(root)
    return if root.nil?
    result = []
    q = []
    q.push(root)

    while !q.empty?
      current = q[0]
      result.push current.data
      q.push(current.get_left) if current.get_left != nil
      q.push(current.get_right) if current.get_right != nil
      q.shift
    end
    result
  end

  def level_order_recursive(root)
  end

  def inorder(root, result = [])
    return if root.nil?

    inorder(root.get_left, result)
    result << root.data
    inorder(root.get_right, result)
    result
  end

  def preorder(root, result = [])
    return if root.nil?

    result << root.data
    preorder(root.get_left, result)
    preorder(root.get_right, result)
    result
  end

  def postorder(root, result = [])
    return if root.nil?

    postorder(root.get_left, result)
    postorder(root.get_right, result)
    result << root.data
  end

  def height(node_to_find)
    node = find(@root,node_to_find)
    measure_height(node)
  end

  def measure_height(root)
    return 0 if root.nil?

    l_height = measure_height(root.get_left)
    r_height = measure_height(root.get_right)
    if l_height > r_height
      l_height + 1
    else
      r_height + 1
    end
  end

  def depth(data_to_find)
    measure_depth(@root, data_to_find)
  end

  def measure_depth(root, data_to_find, level = 1)
    return 0 if root.nil?
    return level if root.data == data_to_find

    step = measure_depth(root.get_left, data_to_find, level + 1)
    return step if step != 0 
    step = measure_depth(root.get_right, data_to_find, level + 1)
    step
  end

  def balanced?
    left_height = height(@root.get_left.data)
    right_height = height(@root.get_right.data)

    if left_height > right_height
      diff = left_height - right_height
    else
      diff = right_height - left_height
    end

    return true if diff < 2
    false
  end

  def rebalance
    array = level_order_iterative(@root)
    build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return puts "Nothing to print" if node.nil?

    pretty_print(node.get_right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.get_right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.get_left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.get_left
  end
end

# test array, unordered, with duplicates
test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 5, 7, 9, 67, 6345, 324, 64, 23, 88, 47, 104, 301, 777, 37, 43]
# test_array = Array.new(30) {rand(1..100)}
bst = Tree.new
bst.build_tree(test_array)
bst.pretty_print

# find
to_find = 67
found_node = bst.find(bst.root, to_find)
puts "Searched for node data: #{to_find}
  Found node: #{found_node},
  Data: #{found_node.data},
  Left child data: #{found_node.get_left.data if found_node.get_left}, 
  Right child data: #{found_node.get_right.data if found_node.get_right}"
puts

# insert + draw new tree
puts "Inserting 6 and 50"
to_insert = 50
bst.insert(bst.root, to_insert)
to_insert = 6
bst.insert(bst.root, to_insert)
bst.pretty_print
puts

# delete + redraw tree
puts "Delete 8"
bst.delete(bst.root, 8)
bst.pretty_print
puts

# level order traversal
puts "Level order traversal:"
p bst.level_order_iterative(bst.root)
puts

# preorder traversal
puts "Preorder Traversal:"
p bst.preorder(bst.root)
puts

# indorder traversal
puts "Inorder Traversal:"
p bst.inorder(bst.root)
puts

# postorder traversal
puts "Postorder Traversal:"
p bst.postorder(bst.root)
puts

# height of a particular node
# level distance between node and furthest leaf node
height_of = 9
puts "Height of node #{height_of}:"
puts bst.height(height_of)
puts

# depth of a node
# level distance between node and root node
depth_of = 50
puts "Depth of node #{depth_of}:"
puts bst.depth(depth_of)
puts

# balanced?
puts "Is the node tree balanced?"
puts bst.balanced?
puts


puts "Unbalance tree with new nodes"
# unbalance tree with insertion
to_insert = 10000
bst.insert(bst.root, to_insert)
to_insert = 10003
bst.insert(bst.root, to_insert)
to_insert = 10004
bst.insert(bst.root, to_insert)
to_insert = 10005
bst.insert(bst.root, to_insert)
to_insert = 10007
bst.insert(bst.root, to_insert)

puts "Rebalance tree"
bst.rebalance
bst.pretty_print

