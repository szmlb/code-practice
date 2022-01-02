fn main() {

    fibo(6);

}

fn fibo(n: u64) -> u64{

    println!("func({}) is called", n);

    if n == 0
    {
        return 0;
    } 
    else if n == 1
    {
        return 1;
    }

    // Compute the answer recursively
    let result: u64 = fibo(n - 1) + fibo(n - 2);
    println!("{} term = {}", n, result);

    return result;
}