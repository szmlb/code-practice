using Random

function insertSort(sort_list)

  # 最初から最後まで全てソート済みになるまで繰り返す
  for sorted_index in 1:length(sort_list)-1
    # ソート済みの領域の直後の値を取り出す
    insert_candidate_value = sort_list[sorted_index + 1]

    # 挿入する場所を見つける(リニアサーチ)
    insert_point_index = 1
    while insert_point_index <= sorted_index
      if sort_list[insert_point_index] > insert_candidate_value
        break
      end
      insert_point_index = insert_point_index + 1
    end

    # ソート済み領域直後の値を挿入する
    while insert_point_index <= sorted_index + 1
      tmp = sort_list[insert_point_index]
      sort_list[insert_point_index] = insert_candidate_value
      insert_candidate_value = tmp
      insert_point_index = insert_point_index + 1
    end

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
  @time insertSort(sort_list)

  print("Sorted list:")
  println(sort_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
