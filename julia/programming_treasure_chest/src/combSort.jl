using Random

function combSort(sort_list)

  gap = length(sort_list)
  print(gap)
  flag = 0

  while true
    gap = (gap * 10) / 13 # 収縮率は1.3が良いとされている(gapが毎回1/1.3になる)
    rounded_gap = Int(round(gap))

    flag = 1
    # 先頭から順に見ていって
    for i in 1:length(sort_list)-rounded_gap
      # 距離がrounded_gapだけ離れた要素を比較し, 並びがおかしければ
      if sort_list[i] > sort_list[i + rounded_gap]
        # 入れ替える
        flag = 0 # 一度でも要素が入れ替えられたらflagを0にする
        tmp = sort_list[i]
        sort_list[i] = sort_list[i + rounded_gap]
        sort_list[i + rounded_gap] = tmp
      end
    end

    # 一度も並び替えをせずに, gapが1未満となったら終了
    if gap < 1 && flag == 1
      break
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
  @time combSort(sort_list)

  print("Sorted list:")
  println(sort_list)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
