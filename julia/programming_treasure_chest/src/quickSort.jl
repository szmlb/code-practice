using Random

function quickSort(bottom, top, sort_list)

    if bottom >= top
      return
    end

    #先頭の値を「適当な値とする」
    div = sort_list[bottom]

    lower = bottom
    upper = top
    while lower < upper
      while lower <= upper && sort_list[lower] <= div
        lower += 1
      end
      while lower <= upper && sort_list[upper] > div
        upper -= 1
      end
      if lower < upper
        tmp = sort_list[lower]
        sort_list[lower] = sort_list[upper]
        sort_list[upper] = tmp
      end
    end

    #最初に選択した値を中央に移動する
    tmp = sort_list[bottom]
    sort_list[bottom] = sort_list[upper]
    sort_list[upper] = tmp

    quickSort(bottom, upper - 1, sort_list)
    quickSort(upper + 1, top, sort_list)

end

function main()

  # list to be sorted
  rng = MersenneTwister(1234);
  list_size = 100
  sort_list = shuffle(rng, Vector(1:list_size))

  print("List to be sorted:")
  println(sort_list)

  # Sort
  @time quickSort(1, length(sort_list), sort_list)

  print("Sorted list:")
  println(sort_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
