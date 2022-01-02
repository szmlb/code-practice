# リストがあるにも関わらずリストを作るけどリストを使うプログラム

using Random

# リストの要素(ノード)を表す構造体
mutable struct tagListNode
    prev # 前の要素への参照
    next # 次の要素への参照
    data::Int    # この要素が持っているデータ
    tagListNode() = new()
end

function main()

  first_node = tagListNode()
  last_node = tagListNode()

  first_node = last_node = nothing

  buf = 1 # 0以外の初期値を代入
  new_node_list = []
  while buf != 0
    println("整数を入力してください (0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      # 新しいノードを作成
      new_node = tagListNode()
      new_node.data = buf
      new_node.next = nothing

      if isempty(new_node_list) != true
        # すでにあるリストの末尾に新しいノードを繋げる
        last_node.next = new_node
        new_node.prev = last_node
        last_node = new_node
      else
        # これが最初の要素だった場合
        first_node = last_node = new_node
        new_node.prev = nothing
      end

      push!(new_node_list, new_node)

    end

  end

  # 合計値を算出
  println("--入力されたのは以下の数です--")
  sum = 0

  this_node = first_node
  while this_node != nothing

    println(this_node.data)
    sum += this_node.data

    this_node = this_node.next
  end
  print("----以上の数の合計値は"); print(sum); println("です")

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
