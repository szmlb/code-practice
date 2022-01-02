fn main() {

    let mut memo: Vec<i64> = Vec::with_capacity(50);
    memo.resize(50, -1);

    fibo(49, &mut memo);

    for n in 2..50
    {
        println!("{} term = {}", n, memo[n]);
    }

}

fn fibo(n: usize, memo: &mut Vec<i64>) -> i64{

    println!("func({}) is called", n);

    if n == 0
    {
        return 0;
    } 
    else if n == 1
    {
        return 1;
    }

    // Check memo
    if memo[n] != -1
    {
        return memo[n];
    }

    // Compute the answer recursively
    memo[n] = fibo(n - 1, memo) + fibo(n - 2, memo);
    return memo[n];
}