using Printf

mutable struct tagStation
    max_station
    name
    transitions::Array{tagStation}
    tagStation(max_station, name) = new(max_station, name)
end

function init_station(self::tagStation, name::String)
    self.transitions = Array{tagStation}(undef, self.max_station)
    for i in 1:self.max_station
        self.transitions[i] = tagStation(10, "")
    end

    self.name = name

end

function add_station(self::tagStation, transition::tagStation)

    # transitionsでまだ登録されていないところを探す
    i_result = 0
    for i in 1:self.max_station
        i_result = i
        if isempty(self.transitions[i].name)
            break
        end
        # すでに登録されているので、何もせずに終了する
        if self.transitions[i].name == transition.name
            return
        end
    end
    # すべて登録されていたら何もしない
    if i_result == self.max_station
        return
    end
    # 新しい乗換駅を登録する
    self.transitions[i_result] = deepcopy(transition)

end

function print_station(self::tagStation)

    @printf "%s: " self.name
    for i in 1:self.max_station

         if isempty(self.transitions[i].name)
            break
        end
        @printf "-> %s " self.transitions[i].name
    end
    @printf "\n"

end

function main()

    station = Array{tagStation}(undef, 6)
    for i in 1:6
        station[i] = tagStation(10, "")
    end

    init_station(station[1], "鎌倉")
    init_station(station[2], "藤沢")
    init_station(station[3], "横浜")
    init_station(station[4], "横須賀")
    init_station(station[5], "茅ヶ崎")
    init_station(station[6], "東京")

    # 鎌倉
    add_station(station[1], station[4])
    add_station(station[1], station[2])
    add_station(station[1], station[3])

    # 藤沢
    add_station(station[2], station[1])
    add_station(station[2], station[5])
    add_station(station[2], station[3])

    # 横浜
    add_station(station[3], station[2])
    add_station(station[3], station[1])
    add_station(station[3], station[6])

    # 横須賀・茅ヶ崎・東京
    add_station(station[4], station[1])
    add_station(station[5], station[2])
    add_station(station[6], station[3])

    for i in 1:6
        print_station(station[i])
    end
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end