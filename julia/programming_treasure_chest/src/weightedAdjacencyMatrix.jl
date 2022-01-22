using Printf

function main()

    station_number = 6

    station = ["横浜", "武蔵小杉", "品川", "渋谷", "新橋", "溜池山王"]

    adjacency_matrix = [0 12 28 0 0 0; 
                        12 0 10 13 0 0;
                        28 10 0 11 7 0;
                        0 13 11 0 0 9;
                        0 0 7 0 0 4;
                        0 0 0 9 4 0]

    for i in 1:station_number
        @printf "%s: " station[i]
        for j in 1:station_number
            if adjacency_matrix[i, j] > 0
                @printf "-> %s(%d分) " station[j] adjacency_matrix[i, j]
            end
        end
        @printf "\n"
    end
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end