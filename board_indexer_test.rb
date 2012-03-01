def find_all_x board
  locations = []
  copy = board

  until copy.index("x").nil?
    locations << copy.index("x")
    copy[copy.index("x")] = "_"
  end

  return locations
end

# require Dir.pwd + "/board_indexer_test.rb"
# board = %w{ _ _ _ _ x _ x _ _ }