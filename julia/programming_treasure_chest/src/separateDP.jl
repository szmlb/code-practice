using Printf
# 未完成

# 表のセルに当たる構造体
mutable struct cell
    sol::Int # この地点の最適の解
    num::Int # その地点から何個か
    cell() = new()
end

function separate(input_array, num, separator)

  solutions = Array{cell}(undef, num, separator+1)

  # 表の後ろの方から順に埋めていく
  for i = N:1
      for j = 1:SEPARATOR+1
          solutions[i][j].num = 0
          sum = 0
          for s = i:N
              sum = sum + input_array[s]
              if j == 1 || i == N || solutions[i][j].num == 0 || (s != N && solutions[i][j].sol > max(sum, solutions[s + 1][j - 1].sol))
                  if j == 0 || i == N
                      # 1行目かもしくは最終列ならば，処理なし
                      solutions[i][j].sol = sum
                  else
                      // よりよい解決方法を記録する
                      solutions[i][j].sol = max(sum, solutions[s + 1][j - 1].sol)
                  end
                  solutions[i][j].num = s - i + 1;
              end
          end
      end
  end

end

function main()

    # 与えられた値と，その分割方法
    N = 10
    SEPARATOR = 3
    value = [15, 3, 7, 6, 10, 4, 13, 2, 3, 6]

    return true
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
