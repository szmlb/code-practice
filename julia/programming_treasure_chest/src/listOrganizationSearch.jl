# リストがあるにも関わらずリストを作るけどリストを使うプログラム

using Random
using Printf

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
  tmp_node = tagListNode()

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

  # 検索値を入力
  buf = 1 # 0以外の初期値を代入
  while buf != 0

    println("現在の並び:")
    this_node = first_node
    while this_node != nothing
      @printf "%d\t" this_node.data
      this_node = this_node.next
    end
    println()

    println("検索する値を入力してください(0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      # 最初に入力した値の中から検索し, 見つかったら削除

      this_node = first_node
      while this_node != nothing

        if this_node.data == buf
          @printf "入力された値の中に%dが見つかりました.\n" buf

          if this_node != first_node
            # 検索で見つかったノードを先頭に持ってくる
            tmp_node.next = this_node.next

            if last_node == this_node
              last_node = tmp_node
            end

            this_node.next = first_node
            first_node = this_node

          end
          break
        end

        tmp_node = this_node
        this_node = this_node.next
      end
      if this_node == nothing
        @printf "%dは入力されていませんでした.\n" buf
      end
    end
  end

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
