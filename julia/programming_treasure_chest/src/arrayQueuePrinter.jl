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

# キューの全内容を表示する
function queue_print(queue)

  i = queue.queue_first
  while i != queue.queue_last
    @printf "%d " queue.data[i]
    i = (i + 1) % queue.queue_max
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

  i = 1
  while i != 0
    @printf "現在のキュー"
    queue_print(queue_struct)
    @printf "\nコマンド 0:終了 1:ジョブをためる 2:ジョブを実行\n>"

    i = parse(Int, readline())

    if i == 1
      @printf "ジョブの識別番号(1~1000)を適当に入力してください:"
      j = parse(Int, readline())
      if j >= 1 && j <= 1000
        queue_push(j, queue_struct)
      end
    elseif i == 2
      j = queue_pop(queue_struct)
      if j == queue_struct.queue_empty
        @printf "ジョブがありません\n"
      else
        @printf "識別番号%dのジョブを実行中...\n" j
      end
    end

  end

  return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
