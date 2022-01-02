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

  # この例では, double型のデータを格納するスタックを作成
  stack_struct.data = Array{Float64}(undef, stack_struct.stack_max)
  # スタック頂上の位置(最下部からのオフセット)
  stack_struct.stack_top = 1

  buf = 1
  while buf != 0
    println("pushする整数を入力してください (0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      stack_push(buf, stack_struct)
    end
  end

  buf = 1
  while buf != 0
    println(stack_struct.data)
    println("popしますか？ (0以外を入力するとpop, 0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      println(stack_pop(stack_struct))
    end
  end

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
