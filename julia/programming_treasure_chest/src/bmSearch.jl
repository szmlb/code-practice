using Printf

function bmSearch(text, pattern)

    # char型全体について, その文字で一致しなかった場合
    # どれだけ比較点を移動するかのテーブル
    table = Array{Int}(undef, 256)

    for i in 1:length(table)
      # 大抵の文字は, 失敗した場合, patternの長さぶん比較点をずらせば良い
      table[i] = length(pattern)
    end
    for i in 1:length(pattern)-1
      # パターンに含まれている文字はその文字に合わせてずらす
      # パターンに同じ文字が含まれていた場合は後方の文字優先 (後方の文字で上書き)
      table[Int(pattern[i])] = length(pattern) - (i - 1) - 1
    end

    # 本文の長さを知る
    text_len = length(text)

    # 最初の比較点は，テキストのパターン文字目から
    text_index = length(pattern)
    while text_index < text_len
        # わかりやすいように，いま何を比較しているか表示
        @printf "    本文:%s \nパターン:" text
        for j = 1:text_index - length(pattern)
            @printf " "
        end
        @printf "%s \n" pattern

        # パターンの後ろから比較を始める
        pattern_index = length(pattern)
        while text[text_index] == pattern[pattern_index]
            if pattern_index == 1
                # パターンの先頭文字まで，すべて比較成功
                return true
            end
            text_index = text_index - 1
            pattern_index = pattern_index - 1
        end

        if table[Int(text[text_index])] > length(pattern) - pattern_index
            # その文字に応じて，比較点を移動
            text_index = text_index + table[Int(text[text_index])]
        else
            # パターンが前にずれるのを防ぐ
            # 下の式はパターンを1つ後ろにずらしている
            text_index = text_index + length(pattern) - pattern_index
        end

    end

    return false

end

function main()

    original_text = "On a dark desert highway, cool wind in my hair,"
    original_pattern = "wind"

    result = bmSearch(original_text, original_pattern)
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
