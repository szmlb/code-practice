using Printf
using Logging

mutable struct tagBonsuu
    bunbo::Int
    bunsi::Int
    tagBonsuu() = new()
end

function Base.:+(x::tagBonsuu, y::tagBonsuu)
    z = tagBonsuu()
    z.bunsi = y.bunsi * x.bunbo + x.bunsi * y.bunbo
    z.bunbo = x.bunbo * y.bunbo
    return z
end

function Base.:-(y::tagBonsuu, x::tagBonsuu)
    z = tagBonsuu()
    z.bunsi = y.bunsi * x.bunbo - x.bunsi * y.bunbo
    z.bunbo = x.bunbo * y.bunbo
    return z
end

function Base.:*(y::tagBonsuu, x::tagBonsuu)
    z = tagBonsuu()
    z.bunsi = y.bunsi * x.bunsi
    z.bunbo = x.bunbo * y.bunbo
    return z
end

function Base.:/(y::tagBonsuu, x::tagBonsuu)
    z = tagBonsuu()
    z.bunsi = y.bunsi * x.bunbo
    z.bunbo = y.bunbo * x.bunsi
    if y.bunbo == 0
        error("０で除算しました\n")
    end
    return z
end

# キューにデータをpush
function stack_push(val, stack)

    # スタックにBONSUUをプッシュする
    if length(stack) != 10
        push!(stack, val)
    else
        error("スタックオーバーフローです。数字が大きすぎます\n")
    end

end

# キューにデータをpush
function stack_pop(stack)

    # スタックにBONSUUをプッシュする
    if length(stack) >= 0
        popped = pop!(stack)
    else
        error("スタックアンダーフローです。演算子の場所が違います\n")
    end

    return popped
end

function main()

    stack_array = Array{tagBonsuu}(undef, 0)
    @printf "逆ポーランド記法で数式を入力してください\n"
    line = readline()

    for c in line
        st1 = tagBonsuu()
        st2 = tagBonsuu()

        if c >= '0' && c <= '9'
            # 数字だった場合は其の数字をそのままスタックに入れる
            st1.bunbo = 1
            st1.bunsi = parse(Int, c)
            stack_push(st1, stack_array)

            @info stack_array
        else
            # 数字でなかった場合はスタックの上２つの数字を取ってきて演算する
            st1 = stack_pop(stack_array)
            st2 = stack_pop(stack_array)
            if c == '+'
                st2 = st2 + st1
                stack_push(st2, stack_array)
            elseif c == '-'
                st2 = st2 - st1
                stack_push(st2, stack_array)
            elseif c == '*'
                st2 = st2 * st1
                stack_push(st2, stack_array)
            elseif c == '/'
                st2 = st2 / st1
                stack_push(st2, stack_array)
            else
                error("無効な文字が入っています\n")
            end

            @info stack_array
        end
    end

    st1 = stack_pop(stack_array)
    if length(stack_array) != 0
        # スタックに数字がまだ残っている場合
        error("正しくない数式です。数字が大きすぎます。\n")
    end
    @printf("解は%lfです", st1.bunsi / st1.bunbo)

    @info stack_array

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end