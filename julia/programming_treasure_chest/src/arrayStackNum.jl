using Printf

mutable struct stack
    data
    stack_max::Int
    stack_top::Int
    stack() = new()
end

# スタックへpush
function stack_push(val, stack)

  if stack.stack_top == stack.stack_max
    # スタックが満杯になっている
    println("エラー: スタックが満杯です (Stack overflow)")
    return false
  else
    # 渡された値をスタックに積む
    stack.data[stack.stack_top] = val
    stack.stack_top+=1
    @printf "stack_top=%d\n" stack.stack_top
  end

end

# スタックからデータをpop
function stack_pop(stack)

  if stack.stack_top == 1
    # スタックには何もない
    println("エラー: スタックが空なのにpopが呼ばれました (Stack underflow)")
    return false
  else
    # 一番上の値を返す
    stack.stack_top-=1
    return stack.data[stack.stack_top]
  end

end

function main()

  stack_struct  = stack()
  stack_struct.stack_max  = 10

  # 配列によるスタック構造
  stack_struct.data = Array{Float64}(undef, stack_struct.stack_max)
  # スタック頂上の位置(最下部からのオフセット)
  stack_struct.stack_top = 1

  buffer = Array{Char}(undef, 256)

  while buffer[1] != '='
    @printf "現在のスタック(%d個):" stack_struct.stack_top
    for i in 1:stack_struct.stack_top
      @printf "%0.3f " stack_struct.data[i]
    end
    @printf "\n>"
    buffer = readline() #Char

    if buffer[1] == '+'
      cal1 = stack_pop(stack_struct)
      cal2 = stack_pop(stack_struct)
      stack_push(cal2 + cal1, stack_struct)
    elseif buffer[1] == '-'
      cal1 = stack_pop(stack_struct)
      cal2 = stack_pop(stack_struct)
      stack_push(cal2 - cal1, stack_struct)
    elseif buffer[1] == '*'
      cal1 = stack_pop(stack_struct)
      cal2 = stack_pop(stack_struct)
      stack_push(cal2 * cal1, stack_struct)
    elseif buffer[1] == '/'
      cal1 = stack_pop(stack_struct)
      cal2 = stack_pop(stack_struct)
      stack_push(cal2 / cal1, stack_struct)
    elseif buffer[1] == '='
      # =の場合はこのすぐ後でwhile文からも抜ける
    else
      # 入力された値は数字のはずなので, スタックに積む
      stack_push(parse(Float64, String(buffer)), stack_struct)
    end

  end

  @printf "計算結果は %f です。\n:" stack_pop(stack_struct)
  if stack_struct.stack_top != 1
    @printf "エラー: スタックにまだ数が残っています\n"
    return false
  end

  return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
