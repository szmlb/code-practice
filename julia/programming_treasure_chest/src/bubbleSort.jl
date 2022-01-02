using Random

function bubbleSort(sort_list)

    flag = 1

    while flag == 1
      flag = 0
      for i in 1:length(sort_list)-1
        if sort_list[i] > sort_list[i+1]
          # 左右の並びがおかしければ入れ替える
          flag = 1
          tmp = sort_list[i]
          sort_list[i] = sort_list[i+1]
          sort_list[i+1] = tmp
        end
        # 一度も並べ替えをせずに見終わったら終了
      end
    end

end

function bubbleSortImproved(sort_list)

    flag = 1

    while flag == 1
      flag = 0
      k = 0
      for i in 1:length(sort_list)-1-k
        if sort_list[i] > sort_list[i+1]
          # 左右の並びがおかしければ入れ替える
          flag = 1
          tmp = sort_list[i]
          sort_list[i] = sort_list[i+1]
          sort_list[i+1] = tmp
        end
        # 一度も並べ替えをせずに見終わったら終了
      end
      k+=1
    end

end

function main()

  # list to be sorted
  rng = MersenneTwister(1234);
  list_size = 100
  sort_list = shuffle(rng, Vector(1:list_size))

  print("List to be sorted:")
  println(sort_list)

  # Sort
  #@time bubbleSort(sort_list)
  @time bubbleSortImproved(sort_list)

  print("Sorted list:")
  println(sort_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
