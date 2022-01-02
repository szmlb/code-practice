use common;

fn chmin<T: Ord>(a: T, b: T) -> T{
    if a > b
    {
        return b
    }
    else
    {
        return a
    }
}

fn main() {

    let inf = 1 << 60;

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input();

    println!("Type each data: ");
    let mut h: Vec<i64> = Vec::with_capacity(n);
    h.resize(n, 0);
    for i in 0..n {h[i] = common::read_input();}

    // Define array dp, initialized with inf
    let mut dp: Vec<i64> = Vec::with_capacity(n);
    dp.resize(n, inf);

    // Initial condition
    dp[0] = 0;

    // loop
    for i in 1..n 
    {
        dp[i] = chmin(dp[i], dp[i - 1] + (h[i] - h[i-1]).abs());
        if i > 1 
        {
            dp[i] = chmin(dp[i], dp[i - 2] + (h[i] - h[i-2]).abs());
        }
    }
        
    println!("{}", dp[n-1]);

}