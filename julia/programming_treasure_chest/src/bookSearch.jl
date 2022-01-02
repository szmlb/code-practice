using Random

# 蔵書を表すデータ
mutable struct book
    title::String
    author::String
    bookID::Int
    available::Int
    book() = new()
end

# 蔵書のデータを初期化する
function initdata(book_list)

  #=
  push!(book_list, book("book0", "author0", 1000, 1))
  push!(book_list, book("book1", "author1", 502, 0))
  push!(book_list, book("book2", "author2", 731, 0))
  push!(book_list, book("book3", "author3", 628, 1))
  =#

  push!(book_list, book())
  book_list[1].title = "book0"
  book_list[1].author = "author0"
  book_list[1].bookID = 1000
  book_list[1].available = 1

  push!(book_list, book())
  book_list[2].title = "book1"
  book_list[2].author = "author1"
  book_list[2].bookID = 502
  book_list[2].available = 0

  push!(book_list, book())
  book_list[3].title = "book2"
  book_list[3].author = "author2"
  book_list[3].bookID = 731
  book_list[3].available = 0

  push!(book_list, book())
  book_list[4].title = "book3"
  book_list[4].author = "author3"
  book_list[4].bookID = 628
  book_list[4].available = 1

end

# 本のデータをbookIDの順に昇順でクイックソートする
function sortBook(bottom, top, book_list)

    if bottom >= top
      return
    end

    #先頭の値を「適当な値とする」
    div = book_list[bottom].bookID

    lower = bottom
    upper = top
    while lower < upper
      while lower <= upper && book_list[lower].bookID <= div
        lower += 1
      end
      while lower <= upper && book_list[upper].bookID > div
        upper -= 1
      end
      if lower < upper
        tmp = book_list[lower].bookID
        book_list[lower] = book_list[upper].bookID
        book_list[upper] = tmp
      end
    end

    #最初に選択した値を中央に移動する
    tmp = book_list[bottom]
    book_list[bottom] = book_list[upper]
    book_list[upper] = tmp

    sortBook(bottom, upper - 1, book_list)
    sortBook(upper + 1, top, book_list)

end

function searchBook(book_list, search_num)

  left = 1
  right = length(book_list)
  while left <= right
    mid = round(Int, (left + right) / 2, RoundNearestTiesUp)
    if book_list[mid].bookID < search_num
      left = mid + 1
    else
      right = mid - 1
    end
  end
  if search_num == book_list[left].bookID
    return left
  end

  return false

end

function main()

  book_list = []
  initdata(book_list)

  sortBook(1, length(book_list), book_list) # 最初に管理番号順にソートしておく

  # 検索キーとして本の管理番号を入力
  while true

    println("検索する本の番号を入力してください (0で終了)")
    key = parse(Int, readline())

    if key == 0
      break
    end

    # 検索して結果を表示
    position = searchBook(book_list, key)

    if position != false
      println("--次の本が見つかりました--")
      print("[タイトル]"); println(book_list[position].title)
      print("[著者]"); println(book_list[position].author)
      print("[管理番号]"); println(book_list[position].bookID)

      if book_list[position].available != 0
        println("この本は貸出可能です")
      else
        println("この本は貸出中です")
      end
    else
      println("お探しの本は見つかりませんでした")
    end

  end
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
