using Printf
using Logging

Logging.disable_logging(Logging.Info)

mutable struct Separator
    n::Int
    separator::Int
    value::Array{Int}
    sep_pos::Array{Int}
    best_sep_pos::Array{Int}
    best_sep_max_value::Int
    Separator() = new()
end

# 分割を実装する再帰関数
function separate(self::Separator, pos, num)

    # 新しい分割場所を設定
    self.sep_pos[num] = pos
    num = num + 1

    # 分割がすべて決まったら
    if num == self.separator+1
        max = 0

        # 設定された分割で，最大のグループ和を算出する
        for i in 1:self.separator+1
            if i == 1
                _start = 1
                _end = self.sep_pos[i]
            elseif i == self.separator+1
                _start = self.sep_pos[i-1]+1
                _end = self.n
            else
                _start = self.sep_pos[i-1]+1
                _end = self.sep_pos[i]
            end
            k = 0
            for j in _start:_end
                k = k + self.value[j]
            end
            if k > max
                max = k
            end
        end

        @info "sep_pos" self.sep_pos

        # 最大のグループ和が保存されている和より小さければ
        if max < self.best_sep_max_value
            # 現在の分割を保存する
            self.best_sep_max_value = max
            for i in 1:self.separator
                self.best_sep_pos[i] = self.sep_pos[i]
            end
        end
        return
    end

    # 次の分割場所を設定する
    for i_pos in pos+1:self.n-self.separator+num
        separate(self, i_pos, num)
    end
end

function main()

    sd  = Separator()
    # 与えられた値と，その分割方法
    sd.n = 10
    sd.separator = 3
    sd.value = [15, 3, 7, 6, 10, 4, 13, 2, 3, 6]
    sd.sep_pos = zeros(sd.separator)
    # 最適な分割と，そのなかのグループの最大和
    sd.best_sep_pos = zeros(sd.separator)
    sd.best_sep_max_value = 9999

    # 最初の分割場所を設定して再帰を呼び出す
    for i in 1:sd.n-sd.separator+1
        separate(sd, i, 1)
    end

    # 保存された分割場所を表示する
    for i in 1:sd.separator+1
        if i == 1
            _start = 1
            _end = sd.best_sep_pos[i]
        elseif i == sd.separator+1
            _start = sd.best_sep_pos[i-1]+1
            _end = sd.n
        else
            _start = sd.best_sep_pos[i-1]+1
            _end = sd.best_sep_pos[i]
        end

        for j in _start:_end
            @printf "%d " sd.value[j]
        end
        if _end != sd.n
            @printf "| "
        end
    end
    @printf " max value: %d\n" sd.best_sep_max_value

    return true
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end