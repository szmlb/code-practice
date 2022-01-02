using Printf

# 分割を実装する再帰関数
function separate(pos, num)

    # 新しい分割場所を設定
    sep_pos[num] = pos
    num = num + 1

    # 分割がすべて決まったら
    if num == SEPARATOR
        max = 0

        # 設定された分割で，最大のグループ和を算出する
        for i in 1:SEPARATOR
            start = (i == 0) ? 0: sep_pos[i-1]
            end = (i == SEPARATOR)? N: sep_pos[i]
            k = 0
            for j in start:end
                k = k + value[j]
            end
            if k > max
                max = k
            end
        end

        # 最大のグループ和が保存されている和より小さければ
        if max < best_sep_max_value
            # 現在の分割を保存する
            best_sep_max_value = max
            for i in 1:SEPARATOR
                best_sep_pos[i] = sep_pos[i]
            end
        end
        return
    end

    # 次の分割場所を設定する
    for i in pos+1:N-SEPARATOR+num+1
        separate(i, num)
    end
end

function main()

    # 与えられた値と，その分割方法
    N = 10
    SEPARATOR = 3
    value = [15, 3, 7, 6, 10, 4, 13, 2, 3, 6]
    sep_pos = zeros(SEPARATOR)

    # 最適な分割と，そのなかのグループの最大和
    best_sep_pos = zeros(SEPARATOR)
    best_sep_max_value = 9999

    # 最初の分割場所を設定して再帰を呼び出す
    for i in 1:N-SEPARATOR+1
        separate(i, 0)
    end

    # 保存された分割場所を表示する
    for i in 1:SEPARATOR
        start = (i == 0)? 0: best_sep_pos[i - 1]
        end = (i == SEPARATOR)? N: best_sep_pos[i]
        for j in start:end
            @printf "%d " value[j]
        end
        if end != N
            @printf "|"
        end
    end

    return true
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
