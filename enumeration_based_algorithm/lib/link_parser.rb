require "../bin/link_parser.rb"

file_path = File.expand_path('../../documents/document.html')
parsed_str = LinkParser.new(file_path).run