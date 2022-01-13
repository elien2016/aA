class PolyTreeNode
    attr_reader :parent, :children, :value
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        @parent.children.delete(self) if @parent != nil
        @parent = parent
        @parent.children << self if parent != nil
    end

    def add_child(child_node)
        child_node.parent = self
        @children << child_node if !@children.include?(child_node)
    end

    def remove_child(child_node)
        raise "Node is not a child." if @children.delete(child_node) == nil
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        @children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value == target_value
            queue += el.children
        end
        nil
    end

    def inspect
        "#<Node:#{object_id} @value=#{@value}, @parent=#{@parent}>"
    end
end