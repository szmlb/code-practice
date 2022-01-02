using Random
using Printf

# リストの要素(ノード)を表す構造体
mutable struct tagTreeNode
    left  # 左側のノード
    right # 右側のノード
    key::String    # このノードが持つキー
    val::String    # キーに対応する値
    tagTreeNode() = new()
end

function createNewNode(key, val, node_list)

  node_new = tagTreeNode()
  node_new.left = nothing
  node_new.right = nothing
  node_new.key = key
  node_new.val = val

  return node_new
end

function insertTree(key, val, node, node_list)

  # １つも挿入されていない場合
  if length(node_list) == 0
    node = createNewNode(key, val, node_list)
    push!(node_list, node)
    return
  end

  if cmp(node.key, key) > 0
    # keyが現在のnodeの値よりも小さい場合
    if node.left != nothing
      insertTree(key, val, node.left, node_list)
    else
      # 左側に追加する
      node.left = createNewNode(key, val, node_list)
      push!(node_list, node.left)
    end
  else
    # numが現在のnodeの値位以上の場合
    if node.right != nothing
      insertTree(key, val, node.right, node_list)
    else
      # 右側に追加する
      node.right = createNewNode(key, val, node_list)
      push!(node_list, node.right)
    end
  end

  return

end

function findValue(node, val)
  # 発見したtree_nodeのポインタを返す. ない場合はnothingを返す.

  cmp_val = cmp(node.key, val)

  # 自分より小さい値ならば, 左側
  if cmp_val > 0
    if node.left == nothing # もし左側になければ, 左側にはない
      return nothing
    end
    return findValue(node.left, val)
  end

  # 自分より大きい値ならば, 右側
  if cmp_val < 0
    if node.right == nothing # もし右側になければ, valはない
      return nothing
    end
    return findValue(node.right, val)
  end

  # 見つかれば, 見つかった値を返す
  return node

end

function deleteTree(val, root_node)
  # valを削除する. 成功すればtrue, 失敗すればfalseを返す.

  node = tagTreeNode()
  parent_node = tagTreeNode()
  left_biggest = tagTreeNode()

  node = root_node
  parent_node = nothing
  direction = 0

  # while文で削除すべき対象を見つける(findValueと同じ)
  while node != nothing && cmp(node.key, val) != 0
    cmp_val = cmp(node.key, val)
    if cmp_val > 0
      parent_node = node
      node = node.left
      direction = -1 # 親の左側
    else
      parent_node = node
      node = node.right
      direction = 1 # 親の右側
    end
  end
  if node == nothing # 見つからなかった
    return false
  end

  if node.left == nothing || node.right == nothing
    # 左か右, どちらかがnothingであった場合 (両方nothingである場合も含む)
    if node.left == nothing
      # 親のポインタを変更する
      if direction == -1
        parent_node.left = node.right
      end
      if direction == 1
        parent_node.right = node.right
      end
      if direction == 0
        tree_root = node.right
      end
    else
      # 親のポインタを変更する
      if direction == -1
        parent_node.left = node.left
      end
      if direction == 1
        parent_node.right = node.left
      end
      if direction == 0
        tree_root = node.left
      end
    end

  else
    # 両者ともnothingでなかった場合

    # nodeの左側の最も大きな値(最も右側の値)を取得する
    left_biggest = node.left

    parent_node = node
    direction = -1
    while left_biggest.right != nothing
      parent_node = left_biggest
      left_biggest = left_biggest.right
      direction = 1
    end

    # left_biggestの値をnodeに代入し, left_biggestは左側の枝を入れる
    node.key = left_biggest.key
    if direction == -1
      parent_node.left = left_biggest.left
    else
      parent_node.right = left_biggest.left
    end
  end

    return true
end

function printTree(depth,  node)

  if node == nothing
    return
  end

  printTree(depth + 1, node.left)
  for i in 1:depth
    @printf "  "
  end
  @printf "%s :%s \n" node.key node.val
  printTree(depth + 1, node.right)

end

function main()

  root_node = nothing
  node_list = []

  rng = MersenneTwister(1234)
  for i in 1:5
    insertTree(string(rand(rng, Vector(1:100)), base=10), "hoge", root_node, node_list)
    root_node = node_list[1]
  end

  while true

    printTree(0, root_node)
    @printf "実行する操作のタイプを入力してください. \n 1: 追加\t 2: 検索\t 3:削除\t それ以外: 終了>  "
    action = parse(Int, readline())

    if action == 1
      @printf "挿入する文字列(キー):>"
      tmp = readline()
      @printf "キーに対応させる値:>"
      tmpval = readline()
      insertTree(tmp, tmpval, root_node, node_list)
    elseif action == 2
      @printf "検索する文字列を入力してください:"
      tmp = readline()
      if findValue(root_node, tmp) != nothing
        @printf "%sを発見しました\n" tmp
      else
        @printf "%dは見つかりませんでした\n" tmp
      end
    elseif action == 3
      @printf "削除する文字列を入力してください:"
      tmp = readline()
      if deleteTree(tmp, root_node) == true
        @printf "%dを削除しました\n" tmp
      else
        @printf "%dは見つかりませんでした\n" tmp
      end
    else
      return true
    end
  end
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
