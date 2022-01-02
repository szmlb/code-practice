using Printf

function simpleSearch(text, pattern)

    for i in 1:length(text)-length(pattern)+1
        # わかりやすいように，いま何を比較しているか表示
        @printf "    本文:%s \nパターン:" text
        for j = 1:i-1
            @printf " "
        end
        @printf "%s \n" pattern

        # パターンの先頭から比較を始める
        j = 1
        while j < length(pattern) + 1

            if pattern[j] != text[i+j-1]
                break              # 一致しなかった
            end

          j = j + 1
        end
        if j == length(pattern) + 1        # 一致した
            return text;
        end

        # 一致しなかったので，テキストを1つずらして再度挑戦
    end

    return false
end

function main()

    original_text = "Team Swift"
    original_pattern = "if"

    result = simpleSearch(original_text, original_pattern)
    if result == false
        @printf "見つかりませんでした\n"
    else
        @printf "見つかりました\n"
    end

    return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
