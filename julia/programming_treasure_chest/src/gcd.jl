using Printf

function single_gcd(a, b)

  i = a
  while i > 0
    if a % i == 0 && b % i == 0
      break
    end
    i=i-1
  end
  return i

end

function multi_gcd(n, num_list)

  # n == 1 (数が２つしかない)の場合は, 普通にgcdを呼ぶだけ
  if n == 1
    return single_gcd(num_list[1], num_list[2])
  end

  # n > 1の場合は, num_list[n]と, num_list[1]...num_list[n-1]のgcdを呼び出す
  return single_gcd(num_list[n], multi_gcd(n-1, num_list))

end

function main()

  num_list = [98,  140,  84,  28,  42,  126]

  @printf "配列num_listの最大公約数は%dです\n" multi_gcd(length(num_list)-1, num_list)
  return true

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
