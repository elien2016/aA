class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    @cache.length
  end

  def add(el)
    if !@cache.include?(el)
      if count < @size
        @cache << el
      else
        @cache = @cache.rotate
        @cache[-1] = el
      end
    else
      @cache.delete(el)
      @cache.push(el)
    end
  end

  def show
    p @cache
  end
end