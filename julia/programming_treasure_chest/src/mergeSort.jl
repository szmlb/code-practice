using Random

function mergeSort(n, sort_list)

    if n <= 1
      return
    end
    m = Int(n / 2)

    # ブロックを前半と後半に分ける
    mergeSort(m,  sort_list)
    mergeSort(n - m, sort_list[m:length(sort_list)])

    # 併合(マージ)操作
    buffer = []
    for i in 1:m
      push!(buffer,  sort_list[i])
    end

    j = m
    i = 0
    k = 0

    while i < m && j < n
      if buffer[i] <= sort_list[j]
        k+=1
        i+=1
        sort_list[k] = buffer[i]
      else
        k+=1
        j+=1
        sort_list[k] = buffer[j]
      end
    end
    while i < m
        k+=1
        i+=1
        sort_list[k] = buffer[i]
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
  @time mergeSort(length(sort_list), sort_list)

  print("Sorted list:")
  println(sort_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
