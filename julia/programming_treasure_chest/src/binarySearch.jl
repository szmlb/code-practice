using Random

function binarySearch(search_list, search_num)

  left = 1
  right = length(search_list)
  while left <= right
    mid = round(Int, (left + right) / 2, RoundNearestTiesUp)
    if search_num == search_list[mid]
      return mid
    elseif search_list[mid] < search_num
        left = mid + 1
      else
        right = mid - 1
      end
    end

  return false

end

function binarySearchDuplicated(search_list, search_num)

  left = 1
  right = length(search_list)
  while left <= right
    mid = round(Int, (left + right) / 2, RoundNearestTiesUp)
    if search_list[mid] < search_num
      left = mid + 1
    else
      right = mid - 1
    end
  end
  if search_num == search_list[left]
    return left
  end

  return false

end

function main()

  # list to be sorted
  rng = MersenneTwister(1234);
  list_size = 1e7
  search_list = Vector(1:list_size) # The list is to be sorted for binary search
  search_list[298] = 300
  search_list[299] = 300

  # Search
  search_num = 300
  #index_found = @time binarySearch(search_list, search_num)
  index_found = @time binarySearchDuplicated(search_list, search_num)

  print("Search for : ")
  println(search_num)

  if index_found == false
    println("Nothing found.")
    return
  end

  print("Found index: ")
  println(index_found)

  print("Found value is ... ")
  println(Int(search_list[index_found]))

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
