using Printf
using Logging

mutable struct StructNum
    created_num
    StructNum() = new()
end

mutable struct StructRpn
    issued::Array{Int64}
    created_num
    StructRpn() = new()
end

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

    _val = deepcopy(val)

    # スタックにBONSUUをプッシュする
    if length(stack) != 4
        push!(stack, _val)
    else
        error("スタックオーバーフローです。数字が大きすぎます\n")
    end

end

# キューにデータをpush
function stack_pop(stack)

    # スタックにBONSUUをプッシュする
    if length(stack) >= 0
        popped = deepcopy(pop!(stack))
    else
        error("スタックアンダーフローです。演算子の場所が違います\n")
    end

    return popped
end

function solve(stack::Array{tagBonsuu}, srpn::StructRpn)

    for c in srpn.created_num
        if c == '\0'
           break;
        end

        st1 = tagBonsuu()
        st2 = tagBonsuu()

        if c >= '0' && c <= '9'
            # 数字だった場合は其の数字をそのままスタックに入れる
            st1.bunbo = 1
            st1.bunsi = parse(Int, c)
            stack_push(st1, stack)

        else
            # 数字でなかった場合はスタックの上２つの数字を取ってきて演算する
            st1 = stack_pop(stack)
            st2 = stack_pop(stack)
            if c == '+'
                st2 = st2 + st1
                stack_push(st2, stack)
            elseif c == '-'
                st2 = st2 - st1
                stack_push(st2, stack)
            elseif c == '*'
                st2 = st2 * st1
                stack_push(st2, stack)
            elseif c == '/'
                st2 = st2 / st1
                if st2.bunbo == 0
                    # ０で割り算してしまった場合は失敗
                    for i in 1:length(stack)
                        stack_pop(stack)
                    end
                    return false
                end
                stack_push(st2, stack)

            else
                error("無効な文字が入っています\n")
            end

        end
    end

    st1 = stack_pop(stack)
    if length(stack) != 0
        # スタックに数字がまだ残っている場合
        error("正しくない数式です。数字が大きすぎます。\n")
    end

    if st1.bunbo * 10 == st1.bunsi
        return true
    end
    return false

end

function make_rpn(srpn::StructRpn, snum::StructNum, stack::Array{tagBonsuu}, num, exp)

    # RPNを作成する再帰関数
    if num + exp == 7
        # 全体で７文字であれば表示
        srpn.created_num[8] = '\0'
        #@printf "%s\n" String(srpn.created_num)
        # 全体で７文字であれば、それを計算
        if solve(stack, srpn)
            return true
            # 計算結果が１０になれば、それ以降の再帰を止める
        end
        return false
    else
        if num - exp >= 2
            # 数字が演算子より２つ以上多ければ、演算子を入れても良い
            srpn.created_num[num + exp + 1] = '+'
            if make_rpn(srpn, snum, stack, num, exp + 1)
                return true
            end
            srpn.created_num[num + exp + 1] = '-'
            if make_rpn(srpn, snum, stack, num, exp + 1)
                return true
            end
            srpn.created_num[num + exp + 1] = '*'
            if make_rpn(srpn, snum, stack, num, exp + 1)
                return true
            end
            srpn.created_num[num + exp + 1] = '/'
            if make_rpn(srpn, snum, stack, num, exp + 1)
                return true
            end
        end
        if num <= 3
            # 数が３つ以下であれば、数を入れても良い
            for i in 1:4
                if srpn.issued[i] == 0
                    srpn.issued[i] = 1
                    srpn.created_num[num + exp + 1] = snum.created_num[i]
                    if make_rpn(srpn, snum, stack, num + 1, exp)
                        srpn.issued[i] = 0
                        return true
                    end
                    srpn.issued[i] = 0
                end
            end
        end
    end
    return false
end

function make_num(snum::StructNum, srpn::StructRpn, stack::Array{tagBonsuu}, keta, num)

    # 数の組み合わせを作る再帰関数
    if keta == 4
        snum.created_num[5] = '\0'
        # 数が４桁になったらRPNを作成する
        if make_rpn(srpn, snum, stack, 0, 0)
            @printf "%s:%s\n" String(snum.created_num) String(srpn.created_num)
        else
            @printf "%s:解けません\n" String(snum.created_num)
        end
        return
    end
    for i in num:9
        snum.created_num[keta+1] = i + '0' 
        make_num(snum, srpn, stack, keta + 1, i)
    end

end

function main()

    stack = Array{tagBonsuu}(undef, 0)

    snum = StructNum()
    snum.created_num = Array{Char}(undef, 5)

    srpn = StructRpn()
    srpn.issued = zeros(Int64, 4)
    srpn.created_num = Array{Char}(undef, 8)

    make_num(snum, srpn, stack, 0, 0)
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end