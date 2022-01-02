using Random
using Printf

function func(x)

  return x^5 - 10x^4 + 25x^3 + 40x^2 +200x - 500

end

# 2分探索法（バイナリサーチ）
function binarySearch()

    #=
     ↓「答に非常に近い」という範囲を定義する。
        この値をいろいろと変えることで，答の精度を調節できる。
        ちなみに，あまり小さくしすぎると情報落ちの関係で
        答が求まらなくなってしまうので注意。
    =#
    epsilon=0.00001

    # 「leftとrightの間に確実に解がある」という範囲を指定する
    left = 1.0
    right = 3.0

    # 範囲をひたすら絞り込む
    while abs(right - left) > epsilon && abs(func(left)) > epsilon
        mid = (left + right) / 2.0;

        # func(left)とfunc(mid)が同符号なら
        if func(left) * func(mid) >= 0.0
            left = mid           # leftの位置をmidに合わせる
        else
            right = mid          # rightの位置をmidに合わせる
        end
    end
    return left
end

function main()

    d = binarySearch()
    @printf "方程式の解は%lf そのときのfunc(x)は%lfです。\n" d func(d)
    return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
