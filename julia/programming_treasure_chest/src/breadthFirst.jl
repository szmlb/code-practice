using Printf

# いままでに現れた局面を記録する配列。
# この配列は，キュー代わりにも使われる
mutable struct pattern
    hash::Int
    pattern_from::Int
    pattern() = new()
end

# 局面と対応する数字を作り出す関数
function make_hash(pattern)

    hash = 0;
    for i in 1:8
      #hash |= ((unsigned long)(pattern[7 - i])) << (i * 4);
    end
    return hash
end

# 数字から局面を復元する関数
function pattern_from_hash(pattern, hash)

    for i in 1:8
      #pattern[7 - i] = (char)((hash >> (i * 4)) & 0xf)
    end

end

function save_history(pattern, pattern_from, history, history_count)

    hash = make_hash(pattern)
    # いままでの局面と比較する
    for i = 1:history_count
        if history[i].hash == hash
            return
        end
    end

    # 新しく出てきた局面を保存
    history_count += 1
    history_tmp = pattern()
    push!(history, history_tmp)

    if length(history) == 0
        @printf "メモリが足りません"
        return false
    end
    history[history_count - 1].hash = hash
    history[history_count - 1].pattern_from = pattern_from

end

function solve_7puzzle(history, history_count)

    pattern = Array{Char}(undef, 8) # パネル配置

    # ↑添え字と場所の対応は次のとおり。
    # 0 1 2 3
    # 4 5 6 7

    queue_bottom = 0
    while queue_bottom != history_count
    # キューが空になるまで繰り返す
        #  キューから1つ取得する
        hash = history[queue_bottom].hash

        if hash == 0x12345670
        # 解にたどり着いたら終了
            return true
        end
        pattern_from_hash(pattern, hash)
        for blank_pos in 1:8
            if pattern[blank_pos] == 0
                break
            end
        end
        if blank_pos > 3
        # 上から空いている場所へ移動
            pattern[blank_pos] = pattern[blank_pos - 4]
            pattern[blank_pos - 4] = 0
            # 新しいパネル配置を保存したあと，元の配置に戻す
            save_history(pattern, queue_bottom)
            pattern_from_hash(pattern, hash)
        end
        if blank_pos < 4
        # 下から空いている場所へ移動
            pattern[blank_pos] = pattern[blank_pos + 4]
            pattern[blank_pos + 4] = 0
            save_history(pattern, queue_bottom)
            pattern_from_hash(pattern, hash)
        end
        if blank_pos != 0 && blank_pos != 4
        # 左から空いている場所へ移動
            pattern[blank_pos] = pattern[blank_pos - 1]
            pattern[blank_pos - 1] = 0
            save_history(pattern, queue_bottom)
            pattern_from_hash(pattern, hash)
        end
        if blank_pos != 3 && blank_pos != 7
        # 右から空いている場所へ移動
            pattern[blank_pos] = pattern[blank_pos + 1]
            pattern[blank_pos + 1] = 0
            save_history(pattern, queue_bottom)
        end
        queue_bottom += 1
    end
    return false   # 解が見つからなかった場合

end

function main()

    pattern = [2, 7, 1, 4, 5, 0, 3, 6]
    pattern = convert(Array{Char}, pattern)

    history = nothing
    history = []

    history_count = 0
    # 最初の1つ目のパターンを記録
    save_history(pattern, -1, history, history_count)

    if solve_7puzzle(history, history_count) == false
        @printf "全パターンを試しましたが, 解が見つかりませんでした。"
    else
        # 解を表示する
        last = -1;
        while last != queue_bottom
            # 最初の解から表示していく
            i = queue_bottom
            while history[i].pattern_from != last
                i = history[i].pattern_from
                i += 1
            end
            last = i

            # パネル配置を表示
            pattern_from_hash(pattern, history[last].hash)
            for i in 1:8
                @printf "%c " (pattern[i] == 0) ? pattern[i] + '0' : ' '
                if i % 4 == 3
                    @printf "\n"
                end
            end
            read(stdin, Char)  # リターンキーで次を表示
        end
    end

    return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
