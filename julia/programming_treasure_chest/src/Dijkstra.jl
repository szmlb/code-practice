using Printf

function main()

    station_number = 6
    start_station = 1

    station = ["横浜", "武蔵小杉", "品川", "渋谷", "新橋", "溜池山王"]

    current_cost = Array{Int64}(undef, station_number)
    fix = Array{Int64}(undef, station_number)

    adjacency_matrix = [0 12 28 0 0 0; 
                        12 0 10 13 0 0;
                        28 10 0 11 7 0;
                        0 13 11 0 0 9;
                        0 0 7 0 0 4;
                        0 0 0 9 4 0]

    # 初期化する
    for i in 1:station_number
        current_cost[i] = -1
        fix[i] = 0
    end
    current_cost[1] = 0 # スタート地点（横浜）の所要時間を０とする

    while(true)
        min_time = -1
        min_station = 1
        for i in 1:station_number
            if fix[i] == 0 && current_cost[i] != -1
                if min_time == -1 || min_time > current_cost[i]
                    # 確定しておらず、最も所要時間の小さい駅を調べる
                    min_time = current_cost[i]
                    min_station = i
                end
            end
        end
        if min_time == -1
            # すべての駅が確定したか、最小の所要時間が無限大だったので終了
            break
        end

        # 自分の駅から伸びているすべての駅の所要時間を調べる
        for i in 1:station_number
            if fix[i] == 0 && adjacency_matrix[min_station, i] > 0
                new_time = min_time + adjacency_matrix[min_station, i] # 自分の駅経由で移動する場合の必要時間
                if current_cost[i] == -1 || current_cost[i] > new_time
                    # いま登録されている時間よりも、この駅経由で移動した時間が速いので、新しい時間を登録する
                    current_cost[i] = new_time
                end
            end
        end
        # 自分の駅を確定する
        fix[min_station] = -1

    end

    for i in 1:station_number
        @printf "%s -> %s :%d分\n" station[start_station] station[i] current_cost[i]
    end

end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end