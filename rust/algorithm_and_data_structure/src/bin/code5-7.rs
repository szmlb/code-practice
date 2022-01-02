use common;
use ndarray::Array2;

fn chmax<T: Ord>(a: T, b: T) -> T{
    if a < b
    {
        return b
    }
    else
    {
        return a
    }
}

fn main() {

    // example:
    // n = 6
    // (weight, value) = {(2, 3), (1, 2), (3, 6), (2, 1), (1, 3), (5, 85)}
    // ans = 8

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input();

    println!("Type maximum weight: ");
    let w: usize = common::read_input();

    println!("Type weight data: ");
    let mut weight: Vec<i64> = Vec::with_capacity(n);
    weight.resize(n, 0);
    for i in 0..n {weight[i] = common::read_input();}

    println!("Type value data: ");
    let mut value: Vec<i64> = Vec::with_capacity(n);
    value.resize(n, 0);
    for i in 0..n {value[i] = common::read_input();}

    // A table for input data
    let mut dp = Array2::<i64>::zeros((n+1,w+1));

    // DP loop
    for i in 0..n {
        for j in 0..w+1 {

            // In case i-th item is chosen
            if j as i64 - weight[i] >= 0
            {
                let idx = j - (weight[i] as usize);
                dp[[i+1, j]] = chmax(dp[[i+1, j]], dp[[i, idx]] + value[i]);
            }

            // In case i-th item is NOT chosen
            dp[[i+1, j]] = chmax(dp[[i+1, j]], dp[[i, j]]);

        }
    }
    println!("{}", dp[[n, w]]);

}
