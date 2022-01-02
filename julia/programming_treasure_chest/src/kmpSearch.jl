using Printf

function kmpSearch(text, pattern)

    # まずkmpの検索に必要な情報を集め, テーブルとして保存する
    table = Array{Int}(undef, length(pattern)+1)
    text_index = 2
    pattern_index = 1
    while text_index < length(pattern)+1
      if pattern[text_index] == pattern[pattern_index]
        # 一致したら再検索はpattern_index文字から始めれば良い
        text_index += 1
        pattern_index += 1
        table[text_index] = pattern_index
      elseif pattern_index == 1
        # パターン一文字目で不一致ならば, 再検索は先頭から
        text_index += 1
        table[text_index] = 1
      else
        # パターン一文字目以外で不一致ならば, 再検索の位置はtableから参照
        pattern_index = table[pattern_index]
      end
    end
    # 以上でテーブルが完成, 実際の検索に取り掛かる

    text_index = 1
    pattern_index = 1
    while text_index < length(text) + 1
        # わかりやすいように，いま何を比較しているか表示
        @printf "    本文:%s \nパターン:" text
        for j = 1:text_index-1
            @printf " "
        end
        @printf "%s \n" pattern[pattern_index]

        if pattern[pattern_index] == text[text_index]
          # テキストとパターンが一致していれば, 一文字ずつ比較を続ける
          text_index += 1
          pattern_index += 1

          if pattern_index == length(pattern) + 1        # 一致した
            # 全て一致すれば, 正解
            return text_index - length(pattern)
          end

        elseif pattern_index == 1
          # パターン最初の文字で失敗した場合は, 比較場所を１つ進める
          text_index += 1
        else
          # 最初の文字でない場合は, テーブルから比較位置を取得する
          pattern_index = table[pattern_index]
        end

    end

    return false

end

function main()

    original_text = "a eighty-eighty-eighth key"
    original_pattern = "eighty-eighth"

    result = kmpSearch(original_text, original_pattern)
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
