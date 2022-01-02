using Printf

# １つのカッコを示す構造体
mutable struct staple
    next             # 次のノード
    prev             # 前のノード
    line::Int        # カッコのある行
    column::Int      # カッコのある列 (行頭からの文字列)
    staple_type::Int        # カッコの種類
    staple() = new()
end

# リスト用
mutable struct stack
    new_node_list
    staple_head
    staple_last
    staple_small::Int
    staple_medium::Int
    staple_large::Int
    stack() = new()
end

# スタックへpush
function stack_push(line, column, staple_type, stack)

  staple_new = staple()

  # 渡された値をスタックに積む
  staple_new.line = line
  staple_new.column = column
  staple_new.staple_type = staple_type

  # リストの最後に追加する
  staple_new.next = nothing
  staple_new.prev = stack.staple_last
  stack.staple_last = staple_new
  if stack.staple_head == nothing
    stack.staple_head = staple_new
  end
  push!(stack.new_node_list, staple_new)

end

# スタックからデータをpop
function stack_pop(ret_node, stack)

  staple_tmp = staple()

  if stack.staple_head == nothing
    # スタックには何もしない : カッコの対応が取れていない
    return false
  end

  # 一番最後にpushされたカッコの情報を返す
  ret_node.line = stack.staple_last.line
  ret_node.column = stack.staple_last.column
  ret_node.staple_type = stack.staple_last.staple_type
  ret_node.next = ret_node.prev = nothing
  staple_tmp = stack.staple_last

  # リストから削除する
  if stack.staple_last.prev == nothing
    stack.staple_head = nothing # 要素が１つだったら先頭を消す
  else
    stack.staple_last.prev.next = nothing # そうでなければ最後を消す
  end

  stack.staple_last = stack.staple_last.prev # １つ前を最後の要素にする

  return true # 成功

end

function main()

  stack_struct  = stack()
  stack_struct.new_node_list = []
  stack_struct.staple_head = nothing
  stack_struct.staple_last = nothing
  stack_struct.staple_small = 1
  stack_struct.staple_small = 2
  stack_struct.staple_small = 3

  stack_push(1, 1, stack_struct.staple_small, stack_struct)

  println(stack_struct.staple_last.line)

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
