fn main() {

    let mut f: Vec<i64> = Vec::with_capacity(50);
    f.resize(50, 0);

    f[0] = 0;
    f[1] = 1;
    for n in 2..50
    {
        f[n] = f[n-1] + f[n-2];
        println!("{} term = {}", n, f[n]);
    }

}