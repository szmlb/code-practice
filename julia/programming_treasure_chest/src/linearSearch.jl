using Random

function linearSearch(search_list, search_num)

  num = 1
  while num <= length(search_list)
    if search_num == search_list[num]
      return num
     end
     num += 1
   end

   return false

end

function linearSearchWithSentinel(search_list, search_num)

  # 最後の値をsearch_listに入れる(番兵)
  tmp = Int(search_list[length(search_list)])
  search_list[length(search_list)] = Int(search_num)

  num = 1
  while true
    if search_num == search_list[num]
      break
    end
    num += 1
  end

  search_list[length(search_list)] = tmp # 配列最後の値を元に戻す
  if num < length(search_list)
     return num # 最後以外で一致
  elseif search_num == tmp
     return num # 最後で一致
  else
     return false
  end

end

function main()

  # list to be sorted
  rng = MersenneTwister(1234);
  list_size = 1e7
  #search_list = Vector(1:list_size) # The list is to be sorted for binary search
  search_list = shuffle(rng, Vector(1:list_size))

  # Search
  search_num = 1000
  index_found1 = @time linearSearch(search_list, search_num)
  index_found2 = @time linearSearchWithSentinel(search_list, search_num)

  print("Search for : ")
  println(search_num)

  if index_found1 == false || index_found2 == false
    println("Nothing found.")
    return
  end

  print("Found index: ")
  print(index_found1); print(" ")
  println(index_found2)

  print("Found value is ... ")
  println(Int(search_list[index_found1]))

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
