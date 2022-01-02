using Random

function organizationSearch(search_list, search_num)

  num = 1
  while num <= length(search_list)
    if search_num == search_list[num]
      break
    end
    num += 1
  end

  if num <= length(search_list)
    if num > 1 # １つ前と入れ替える
      tmp = search_list[num - 1]
      search_list[num - 1] = search_list[num]
      search_list[num] = tmp
      return num - 1
    end
    return num
  end

  return false

end

function main()

  # list to be sorted
  rng = MersenneTwister(1234);
  list_size = 20
  #search_list = Vector(1:list_size) # The list is to be sorted for binary search
  search_list = shuffle(rng, Vector(1:list_size))

  println("The list to be searched : ")
  println(search_list)

  # Search
  search_num = 5
  index_found = @time organizationSearch(search_list, search_num)

  println("Search for : ")
  println(search_num)

  if index_found == false
    println("Nothing found.")
    return
  end

  println("Found index: ")
  println(index_found)

  println("Found value is ... ")
  println(Int(search_list[index_found]))

  println("The list to be searched after search: ")
  println(search_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
