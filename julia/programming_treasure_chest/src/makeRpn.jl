using Printf
using Logging

mutable struct StructRpn
    issued::Array{Int64}
    number::Array{Char}
    created_num
    StructRpn() = new()
end

function make_rpn(self::StructRpn, num, exp)

    # RPNを作成する再帰関数
    if num + exp == 7
        # 全体で７文字であれば表示
        self.created_num[8] = '\0'
        @printf "%s\n" String(self.created_num)
    else
        if num - exp >= 2
            # 数字が演算子より２つ以上多ければ、演算子を入れても良い
            self.created_num[num + exp + 1] = '+'
            make_rpn(self, num, exp + 1)
            self.created_num[num + exp + 1] = '-'
            make_rpn(self, num, exp + 1)
            self.created_num[num + exp + 1] = '*'
            make_rpn(self, num, exp + 1)
            self.created_num[num + exp + 1] = '/'
            make_rpn(self, num, exp + 1)
        end
        if num <= 3
            # 数が３つ以下であれば、数を入れても良い
            for i in 1:4
                if self.issued[i] == 0
                    self.issued[i] = 1
                    self.created_num[num + exp + 1] = self.number[i]
                    make_rpn(self, num + 1, exp)
                    self.issued[i] = 0
                end
            end
        end
    end
end

function main()
    struct_rpn = StructRpn()
    struct_rpn.issued = zeros(Int64, 4)
    struct_rpn.number = collect("1234")
    struct_rpn.created_num = Array{Char}(undef, 8)
    make_rpn(struct_rpn, 0, 0)
end

if occursin(PROGRAM_FILE, @__FILE__)
    main()
end