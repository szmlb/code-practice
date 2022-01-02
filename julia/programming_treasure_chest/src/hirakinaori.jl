using Printf

# numのなかに, digit(0-9の一桁の整数)が何文字あるか数える関数
function numOfDigit(num, digit)

  ret = 0

  # 0桁ならば0を返す(何も含まれていない)
  if num == 0
    return 0
  end

  # 1の位が"digit"であるかどうかのチェック
  if num % 10 == digit
    ret = 1 # "digit"であれば, 返り値に１つ足す
  end

  # 10で割ることによって, 次の桁以降のチェックを再帰的に行う
  ret = ret + numOfDigit(round(Int, num / 10, RoundDown),  digit)

  return ret

end

function checkNumber(power, number_using)

  # 数字群を元に計算した結果の数字の個数が
  # 元の数字群と同じだけ使われているかどうかのチェック
  # 0は考慮しない

  result = 0

  # 数字群を元に, 計算結果を生成する
  for i in 1:9
    result = result + power[i+1] * number_using[i+1]
  end

  # 計算結果の中の数字の個数が, 数字群と同じかどうかチェックする
  for i in 1:9
    if numOfDigit(result, i) != number_using[i+1]
      return
    end
  end

  @printf "%lu \n" result
  return

end

function makeNumbers(start, num, power, number_using)

  # 10桁を越えた数字に開き直り数は存在しない
  if num > 10
    return
  end

  # start~9までの数を新たに生成する
  for i in start:9
    # 新しい数を末尾に追加する
    number_using[i+1] = number_using[i+1] + 1
    # それが開き直り数になるかどうかのチェック
    checkNumber(power, number_using)
    # 追加した数の後ろにさらに１桁追加した場合を調べる
    makeNumbers(i,  num+1, power,  number_using)
    # 先ほど追加した数を消す
    number_using[i+1] = number_using[i+1] - 1
  end

end

function main()

  power = Array{UInt128}(undef, 10)
  number_using = Array{Int}(undef, 10)

  # あらかじめべき乗数を計算して, power配列に保存する
  # 0の0乗は0なので, 1から9まで計算すれば良い
  for i in 1:9
    k = 1
    for j in 1:i
      k = k * i
    end
    power[i+1] = k
  end

  # 1を1つ使うという条件から始める
  makeNumbers(1, 1, power, number_using)

  return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    @time main()
end
