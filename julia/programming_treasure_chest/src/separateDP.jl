using Printf
using Logging

# 表のセルに当たる構造体
mutable struct cell
    sol::Int # この地点の最適の解
    num::Int # その地点から何個か
    cell() = new()
end

function separate(input_array, n, separator)

    solutions = Array{cell}(undef, n, separator+1)
    for i in 1:n
        for j in 1:separator+1
            solutions[i, j] = cell()
        end
    end

    # 表の後ろの方から順に埋めていく
    for i = n:-1:1
        for j = 1:separator+1
            solutions[i, j].num = 0
            sum = 0
            for s = i:n
                sum = sum + input_array[s]
                if j == 1 || i == n || solutions[i, j].num == 0 || (s != n && solutions[i, j].sol > max(sum, solutions[s + 1, j - 1].sol))
                    if j == 1 || i == n
                        # 1行目かもしくは最終列ならば，処理なし
                        solutions[i, j].sol = sum
                    else
                        # よりよい解決方法を記録する
                        solutions[i, j].sol = max(sum, solutions[s + 1, j - 1].sol)
                    end
                    solutions[i, j].num = s - i + 1;
                end
            end
        end
    end

    return solutions

end

function main()

    # 与えられた値と，その分割方法
    N = 10
    SEPARATOR = 3
    value = [15, 3, 7, 6, 10, 4, 13, 2, 3, 6]

    solutions = separate(value, N, SEPARATOR)

    @printf "最大の和:%d\n分割方法\n" solutions[1, SEPARATOR+1].sol
    i = 1
    for j = SEPARATOR+1:-1:1
        @printf "[%d個] \n" solutions[i, j].num
        i = i + solutions[i, j].num
        if i == N
            break
        end
    end

    return true
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end