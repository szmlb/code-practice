use common;
use ndarray::Array2;

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

    // No example

    // initialize variable for storing an answer, with INF
    let inf = 1 << 60;

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input();

    // A table for input data
    let mut c = Array2::<i64>::zeros((n+1, n+1));
    for i in 0..n+1 {
        for j in 0..n+1 {
            c[[i, j]] = common::read_input();
        }
    }

    // A table for input data / memo
    let mut dp: Vec<i64> = Vec::with_capacity(n);
    dp.resize(n, inf);

    // DP initial condition
    dp[0] = 0;

    // DP loop
    for i in 0..n+1 {
        for j in 0..i {
            dp[i] = chmin(dp[i], dp[j] + c[[j, i]]);
        }
    }
    println!("{}", dp[n]);

}