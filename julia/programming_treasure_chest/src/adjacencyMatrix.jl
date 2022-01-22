using Printf

function main()

    station_number = 6

    station = ["鎌倉", "藤沢", "横浜", "横須賀", "茅ヶ崎", "東京"]

    """
    adjacency_matrix = [0 1 1 1 0 0; 
                        1 0 1 0 1 0;
                        1 1 0 0 0 1;
                        1 0 0 0 0 0;
                        0 1 0 0 0 0;
                        0 0 1 0 0 0]
    """

    adjacency_matrix = [0 1 0 1 0 0; 
                        0 0 1 0 1 0;
                        1 0 0 0 0 1;
                        1 0 0 0 0 0;
                        0 1 0 0 0 0;
                        0 0 1 0 0 0]

    for i in 1:station_number
        @printf "%s: " station[i]
        for j in 1:station_number
            if adjacency_matrix[i, j] == 1
                @printf "-> %s " station[j]
            end
        end
        @printf "\n"
    end
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end