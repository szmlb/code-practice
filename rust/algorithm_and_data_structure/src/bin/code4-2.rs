fn main() {

    func(5);

}

fn func(n: u64) -> u64{

    println!("func({}) is called", n);

    if n == 0
    {
        return 0;
    } 

    // Compute the answer recursively
    let result: u64 = n + func(n-1);
    println!("Sum of values by {} = {}", n, result);

    return result;
}