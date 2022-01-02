using Printf

# (x,y)にクイーンをおけるかどうかチェックする関数
function check(board, x, y)

    # 左方向にすでにクイーンがあるかどうかをチェック (右側には絶対に存在しない)
    for p in 1:x
        if board[p, y]==1
            return false
        end
    end
    # 左上方向をチェック
    p = x
    q = y
    while p > 1 && q > 1
        p = p - 1
        q = q - 1
        if board[p, q] == 1
            return false
        end
    end
    # 左下方向をチェック
    p = x
    q = y
    while p > 1 && q < size(board)[1]
        p = p - 1
        q = q + 1
        if board[p, q] == 1
            return false
        end
    end

    return true

end

# 現在の盤面を表示
function showboard(board)

    board_size = size(board)

    for y in 1:board_size[1]
        for x in 1:board_size[1]
            @printf "%c " (board[x, y] == 1) ? '姫' : '・'
        end
        @printf "\n"
    end

end

function solve(board, x)

    board_size = size(board)

    if x == board_size[1]+1 # すべての列にクイーンをおけたら
        return true   # 成功
    end

    for i in 1:board_size[1]
        if check(board, x, i)
        # (x,i)にクイーンがおけたら
            # 実際におく
            board[x, i] = 1
            # 次の列におく
            if solve(board, x + 1)      # 次の列以降が成功なら
                return true             # この列も成功
            else                        # 次の列以降が失敗なら
                board[x, i] = 0         # クイーンをおき直す
            end
        end
    end
    return false

end

function main()

    board = Array{Int}(undef, 8, 8) # チェス盤の盤面

    if solve(board, 1) # 最初の列からスタート
        showboard(board)
    end
    return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
