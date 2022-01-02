using Printf

mutable struct queue
    data
    queue_first::Int
    queue_last::Int
    queue_max::Int
    queue_empty::Int
    queue() = new()
end

# キューにデータをpush
function queue_push(val, queue)

  # lastの次がfirstならば
  if queue.queue_last + 1 % queue.queue_max == queue.queue_first
    # 現在配列の中身は、全てキューの要素で埋まっている
    @printf "ジョブが満杯です\n"
  else
    # キューに新しい値を入れる
    queue.data[queue.queue_last] = val
    # queue_lastを１つ後ろにずらす. もし, 一番後ろの場合は, 先頭に持ってくる
    queue.queue_last = (queue.queue_last + 1) % queue.queue_max
  end

end

# キューからデータをpop
function queue_pop(queue)

  if queue.queue_first == queue.queue_last
    # 現在キューは１つもない
    return queue.queue_empty
  else
    # 一番先頭のキューを返す準備
    ret = queue.data[queue.queue_first]
    # キューの先頭を次に移動する
    queue.queue_first = (queue.queue_first + 1) % queue.queue_max
    return ret
  end

end

function main()

  queue_struct  = queue()
  queue_struct.queue_max  = 5 + 1 # キューのサイズ+1
  queue_struct.queue_empty = -1

  # この例では, double型のデータを格納するスタックを作成
  queue_struct.data = Array{Float64}(undef, queue_struct.queue_max)
  # スタック頂上の位置(最下部からのオフセット)
  queue_struct.queue_first = 1
  queue_struct.queue_last = 1

  buf = 1
  while buf != 0
    println("pushする整数を入力してください (0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      queue_push(buf, queue_struct)
    end
  end

  buf = 1
  while buf != 0
    println(queue_struct.data)
    println("popしますか？ (0以外を入力するとpop, 0を入力すると終了)")
    buf = parse(Int, readline())

    if buf != 0 # 新たな入力があったら
      println(queue_pop(queue_struct))
    end
  end

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
