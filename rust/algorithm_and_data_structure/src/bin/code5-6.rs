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

// rec(i) : minimum cost to move from step 0 to step i
fn rec(i: usize, h: &Vec<i64>, dp: &mut Vec<i64>, inf: i64) -> i64{

    // return DP value if it is updated
    if dp[i] < inf
    {
        return dp[i];
    }

    // cost of step 0 is 0
    if i == 0
    {
        return 0;
    }

    // Initialize as with INF
    let mut res = inf;

    // In case moved from step i-1
    res = chmin(res, rec(i-1, &h, dp, inf) + (h[i] - h[i-1]).abs());

    // In case moved from step i-2
    if i > 1
    {
        res = chmin(res, rec(i-2, &h, dp, inf) + (h[i] - h[i-2]).abs());
    }

    dp[i] = res;
    return res;

}

fn main() {

    // example:
    // n = 7
    // h = {2, 9, 4, 5, 1, 6, 10}
    // ans = 8

    // initialize variable for storing an answer, with INF
    let inf = 1 << 60;

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input();

    println!("Type each data: ");
    let mut h: Vec<i64> = Vec::with_capacity(n);
    h.resize(n, 0);
    for i in 0..n {h[i] = common::read_input();}

    // A table for input data / memo
    let mut dp: Vec<i64> = Vec::with_capacity(n);
    dp.resize(n, inf);

    // Brute force search
    let res = rec(n-1, &h, &mut dp, inf);

    println!("{}", res);

}