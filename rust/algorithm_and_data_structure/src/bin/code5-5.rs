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
fn rec(i: usize, h: &Vec<i64>) -> i64{

    // cost of step 0 is zero
    if i == 0
    {
        return 0;
    }

    // initialize variable for storing an answer, with INF
    let inf = 1 << 60;
    let mut res = inf;

    // In case moved from step i-1
    res = chmin(res, rec(i-1, &h) + (h[i] - h[i-1]).abs());

    // In case moved from step i-2
    if i > 1
    {
        res = chmin(res, rec(i-2, &h) + (h[i] - h[i-2]).abs());
    }

    return res;

}

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input();

    println!("Type each data: ");
    let mut h: Vec<i64> = Vec::with_capacity(n);
    h.resize(n, 0);
    for i in 0..n {h[i] = common::read_input();}

    // Brute force search
    let res = rec(n-1, &h);

    println!("{}", res);

}
