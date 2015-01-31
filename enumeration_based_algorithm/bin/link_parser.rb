class LinkParser
  HTML_INSERT = " target='blank'"

  def initialize(path)
    @path = path
    @indices = []
    @file = File.open("#{path}", 'r') { |f| f.read }
  end

  def run
    res = parse(@path)
  end

  def parse(path)
    @file = @file.strip
    enum = @file.each_char.with_index
    
    while enum
      safe_to_continue?(enum)
      
      if enum.next[0] == '<'
        if safe_to_continue?(enum) && enum.next[0] == 'a'
          self.start_tracking(enum)
        end
      end
    end
    
  end

  def start_tracking(enum)
    while enum
      if enum.peek[0] == '>'
        @indices << enum.peek[1]
        enum.next
        return
      else
        return if enum.peek == '<'
        enum.next
      end
    end
  end

  def safe_to_continue?(enum)
    begin
      enum.peek
    rescue StopIteration => char
      exit_safely
    end
  end

  def exit_safely
    self.target_blank_links
    puts @file
    exit
  end

  def target_blank_links
    return if @indices.empty?
    @indices.each_with_index do |file_idx, idx|
      @file.insert(file_idx + (idx * HTML_INSERT.size), HTML_INSERT)
    end
  end
end






