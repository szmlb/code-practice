using Printf

function roundError()

  f1 = Float32(0.1)
  f2 = Float32(0.100000001)

  # f1, f2をそれぞれ20桁(小数点18桁)分表示
  @printf "%20.18f \n%20.18f \n" f1 f2

end

function roundError2()

  f1 = Float64(0.1)
  f2 = Float64(0.100000001)

  # f1, f2をそれぞれ20桁(小数点18桁)分表示
  @printf "%20.18f \n%20.18f \n" f1 f2

end

function cancellationError()

  f1 = Float32(1.0000101)
  f2 = Float32(1.0000100)

  # 「f1-f2」, 「f1+f2」をそれぞれ表示
  @printf "%15.13f-\n%15.13f=%15.13f \n" f1 f2 f1-f2
  @printf "%15.13f+\n%15.13f=%15.13f \n" f1 f2 f1+f2

end

function lossOfTrailingDigit()

  f1 = Float32(1000000.0) # 100万
  f2 = Float32(0.000001)  # 100万分の一

  for i in 1:1000000
    f1 = f1 + f2
  end

  # 1000001が出力されるはず...？
  @printf "%f \n" f1

end

function main()

  @printf "roundError(float32):\n"
  roundError()

  @printf "\n"
  @printf "roundError(float64):\n"
  roundError2()

  @printf "\n"
  @printf "cancelleation error:\n"
  cancellationError()

  @printf "\n"
  @printf "Loss of trailing digit:\n"
  lossOfTrailingDigit()

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end
