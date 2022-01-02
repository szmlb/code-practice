using Printf

function main()

    # 商品の数と，それぞれの大きさ，価値
    N = 5
    size = Array{Int}(undef, N)
    size[1] = 2
    size[2] = 3
    size[3] = 5
    size[4] = 6
    size[5] = 9

    value = Array{Int}(undef, N)
    value[1] = 2
    value[2] = 4
    value[3] = 7
    value[4] = 10
    value[5] = 14

    # ナップザックの大きさ
    nap_size = 16

    # ナップザックの現時点での価値
    nap_value = Array{Int}(undef, nap_size + 1)

    @printf "ナップザックの大きさ:"
    for i in 1:nap_size
        @printf "%2d " i
    end
    @printf "\n\n"

    # 扱う品物を，1つずつ増やしていく
    for i in 1:N
        # ナップザックの大きさがjのものに対して，品物i番を入れてみる
        for j in size[i]:nap_size
            # 品物iを入れてみた場合，新しい価値はどう変わるか
            new_value = nap_value[j + 1 - size[i]] + value[i]

            if new_value > nap_value[j + 1]
                nap_value[j + 1] = new_value
            end
        end

        @printf "品物 %dまで使う:" i
        for j in 1:nap_size
            @printf "%2d " nap_value[j + 1]
        end
        @printf "\n"
    end

    return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
